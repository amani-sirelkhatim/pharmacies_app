import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/Auth/presentation/admin/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pharmacies_app/features/Auth/presentation/signUp.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({super.key});

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  String? _filePath;
  File? file;
  String? profileUrl;
  String? healthpermision;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pharmacy-1a87c.appspot.com');

  Future<String?> uploadFileToFireStore(File file) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('Health-permissions/$timestamp');

      // Determine the file type based on the file extension
      String fileType = file.path.split('.').last;
      String contentType;

      // Set the appropriate content type based on the file type
      switch (fileType) {
        case 'pdf':
          contentType = 'application/pdf';
          break;
        case 'doc':
        case 'docx':
          contentType = 'application/msword';
          break;
        // Add more cases for other file types if needed
        default:
          contentType = 'application/octet-stream'; // Default content type
          break;
      }

      SettableMetadata metadata = SettableMetadata(contentType: contentType);
      await ref.putFile(file, metadata);

      String url = await ref.getDownloadURL();
      setState(() {
        healthpermision = url;
        isloading = false;
      });
      return url;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<void> pickFile(BuildContext context) async {
    if (!mounted) {
      return;
    }
    await _getUser();
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (mounted && result != null) {
        // Do something with the picked file
        setState(() {
          isloading = true;
          _filePath = result.files.first.path;
          file = File(_filePath!);
        });

        String? downloadUrl = await uploadFileToFireStore(file!);
        if (downloadUrl != null) {
          print('File uploaded successfully. Download URL: $downloadUrl');
        } else {
          print('Failed to upload file.');
        }

        print('Picked file: ${result.files.first.path}');
      } else {
        // User canceled the picker
        print('File picking canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  // Future<void> addcvToFirestore({
  //   required String cvurl,
  // }) async {
  //   try {
  //     final CollectionReference imagecollection =
  //         FirebaseFirestore.instance.collection('usermaininfo');

  //     // Add the skill to Firestore with an automatically generated document ID
  //     await imagecollection.doc(user!.uid).set({
  //       'cv': cvurl,

  //       // Add more fields based on your Skill model
  //     }, SetOptions(merge: true));
  //     print(cvurl);
  //   } catch (e) {
  //     print(e);
  //   }

  //   // Optionally, you can clear the text field after adding the skill
  // }

  Future<void> request({
    required String healthpermission,
    required String pharmacyemail,
    required String pharmacyname,
  }) async {
    try {
      var documentReference =
          await FirebaseFirestore.instance.collection('Requests').add({
        'pharmacyname': pharmacyname,
        'pharmacyemail': pharmacyemail,
        'permission': healthpermission,
        'status': 'pending'
      });

// Access the auto-generated document ID
      var requestid = documentReference.id;

// Update the document with the document ID
      await documentReference.update({'id': requestid});
      showSentAlertDialog(context,
          title: 'done',
          ok: 'ok',
          alert: 'Your request has been sent Successfuly',
          Subtiltle: 'you will get the response in your email ', onTap: () {
        Navigator.pop(context);
      });
    } catch (e) {
      print(e);
    }

    // Optionally, you can clear the text field after adding the skill
  }

  showAlertDialog(BuildContext context, {void Function()? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.white,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              width: 600,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'import your Health Permission pdf',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    const Gap(20),
                    CustomButton(
                      text: 'Add',
                      bgcolor: AppColors.primary,
                      onTap: () {
                        pickFile(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  bool isloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).sendrequest,
          style: getTitleStyle(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // IconButton(
              //     onPressed: () {
              //       push(context, MapTest());
              //     },
              //     icon: Icon(Icons.circle)),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text(S.of(context).name),
                  labelStyle: getBodyStyle(),
                  hintText: S.of(context).entername,
                  prefixIcon: Icon(
                    Icons.local_pharmacy,
                    color: AppColors.primary,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).entername;
                  }
                },
              ),
              const Gap(20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text(S.of(context).email),
                  labelStyle: getBodyStyle(),
                  hintText: S.of(context).enteremail,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: AppColors.primary,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).enteremail;
                  } else if (!emailValidate(value)) {
                    return S.of(context).wrongemail;
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20),
              Row(
                children: [
                  Text(S.of(context).permission + " : ",
                      style: getSmallStyle()),
                ],
              ),
              const Gap(10),
              isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Container(
                        //  padding: EdgeInsets.all(1),
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.primary)),
                        child: healthpermision == null
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.primary,
                                  ),
                                  Icon(
                                    Icons.document_scanner_outlined,
                                    color: AppColors.primary,
                                  )
                                ],
                              )
                            : Center(
                                child: Text(S.of(context).update,
                                    style: getSmallStyle(
                                        color: AppColors.primary))),
                      ),
                    ),
              const Gap(30),
              if (healthpermision != null)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Container(
                            padding: EdgeInsets.all(1),
                            height: 150,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.grey),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SfPdfViewer.network(
                                healthpermision.toString(),
                                onDocumentLoaded: (details) {
                                  print("PDF Loaded");
                                },
                                onDocumentLoadFailed: (details) {
                                  print("Failed to load PDF: ${details}");
                                },
                              ),
                            )),
                      ),
                      Gap(10),
                      CustomButton(
                        style: getSmallStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        text: S.of(context).fullpage,
                        bgcolor: AppColors.primary,
                        onTap: () {
                          push(
                              context,
                              fullpage(
                                pdf: healthpermision.toString(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              Gap(30),
              CustomButton(
                  width: 200,
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        healthpermision != null) {
                      QuerySnapshot querySnapshot = await FirebaseFirestore
                          .instance
                          .collection('Requests')
                          .where('pharmacyemail',
                              isEqualTo: _emailController.text)
                          .get();
                      if (querySnapshot != null) {
                        showErrorDialog(context, S.of(context).emailwait);
                      } else {
                        request(
                            healthpermission: healthpermision.toString(),
                            pharmacyemail: _emailController.text,
                            pharmacyname: _nameController.text);
                      }
                    }
                  },
                  text: S.of(context).request,
                  bgcolor: AppColors.primary),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController2,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        label: Text(S.of(context).email),
                                        labelStyle: getBodyStyle(),
                                        hintText: S.of(context).enteremail,
                                        prefixIcon: Icon(
                                          Icons.email_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S.of(context).enteremail;
                                        } else if (!emailValidate(value)) {
                                          return S.of(context).wrongemail;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(20),
                                    CustomButton(
                                      width: 200,
                                      text: S.of(context).continuesignup,
                                      bgcolor: AppColors.primary,
                                      onTap: () async {
                                        if (_emailController2 != null) {
                                          QuerySnapshot querySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('Requests')
                                                  .where('pharmacyemail',
                                                      isEqualTo:
                                                          _emailController2
                                                              .text)
                                                  .where('status',
                                                      isEqualTo: 'accepted')
                                                  .get();
                                          if (querySnapshot != null) {
                                            push(context, SignUp(type: 1));
                                          } else {
                                            showErrorDialog(context,
                                                S.of(context).emailcheck);
                                          }
                                        }
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                    S.of(context).Aproval,
                    style: getBodyStyle(color: AppColors.primary),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
