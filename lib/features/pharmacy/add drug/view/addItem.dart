import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/view/decription.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.Cat});
  final String Cat;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  bool isloading = false;
  int type = 0;
  bool needed = false;
  void toggleNeeded() {
    setState(() {
      needed = !needed;
    });
  }

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

  late String image;
  late String image1;
  late String image2;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pharmacy-1a87c.appspot.com');
  Future<String> uploadImageToFireStore(File image, int type) async {
    setState(() {
      isloading = true;
    });
    String? foldername;
    if (type == 1) {
      setState(() {
        foldername = 'frontImages';
      });
    } else {
      setState(() {
        foldername = 'backImages';
      });
    }
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      String imagePath = 'products/$foldername/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      if (type == 1) {
        setState(() {
          image1 = url;
          print('done$image1');
        });
      } else {
        setState(() {
          image2 = url;
          print('done$image2');
        });
      }

      return url;
    } catch (e) {
      print('Error during image upload to Firestore: $e');
      return '';
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  // Future<void> addImageToFirestore({required String imageUrl}) async {
  //   try {
  //     final CollectionReference imageCollection =
  //         FirebaseFirestore.instance.collection('Pharmacy');

  //     await imageCollection.doc(user!.uid).set({
  //       'image': imageUrl,
  //     }, SetOptions(merge: true));

  //     print('Image added to Firestore: $imageUrl');
  //   } catch (e) {
  //     print('Error adding image to Firestore: $e');
  //   }
  // }

  Future<void> _showUploadoptions(int type) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Photo Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
                final imageUrl = await uploadImageToFireStore(file!, type);
                print('Image uploaded successfully: $imageUrl');
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }

                final imageUrl = await uploadImageToFireStore(file!, type);
                print('Image uploaded successfully: $imageUrl');
                //   pickVideo(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary)),
        centerTitle: true,
        title: Text(
          S.of(context).adddrug,
          style: getTitleStyle(color: AppColors.primary),
        ),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    style: TextStyle(color: AppColors.black),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      focusColor: AppColors.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(S.of(context).drugname),
                      labelStyle: getBodyStyle(),
                      hintText: S.of(context).drugname,
                      prefixIcon: Icon(
                        Icons.local_pharmacy_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    controller: _name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).drugname;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    style: TextStyle(color: AppColors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusColor: AppColors.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(S.of(context).price),
                      labelStyle: getBodyStyle(),
                      hintText: S.of(context).price,
                      prefixIcon: Icon(
                        Icons.monetization_on_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    controller: _price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).price;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Text(S.of(context).Perscription + " :",
                          style: getBodyStyle(color: AppColors.black)),
                      const Gap(20),
                      GestureDetector(
                        onTap: () {
                          toggleNeeded();
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(5)),
                          child: needed
                              ? Icon(
                                  Icons.done_all,
                                  color: AppColors.primary,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).frontImage + " :",
                              style: getBodyStyle(color: AppColors.black)),
                          const Gap(30),
                          Text(S.of(context).backImage + " :",
                              style: getBodyStyle(color: AppColors.black)),
                        ],
                      ),
                      const Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showUploadoptions(1);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.primary)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.primary,
                                  ),
                                  Icon(
                                    Icons.image_rounded,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(20),
                          GestureDetector(
                            onTap: () {
                              _showUploadoptions(2);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.primary)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColors.primary,
                                  ),
                                  Icon(
                                    Icons.image_rounded,
                                    color: AppColors.primary,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ]),
              )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
            onTap: () {
              if (_formKey.currentState!.validate() &&
                  image1.isNotEmpty &&
                  image2.isNotEmpty) {
                push(
                    context,
                    Description(
                      name: _name.text,
                      price: _price.text,
                      image1: image1,
                      image2: image2,
                      needed: needed,
                      cat: widget.Cat,
                    ));
              } else {
                showErrorDialog(
                    context, 'Make sure you added both of the images');
              }
            },
            style: getTitleStyle(color: AppColors.white),
            text: S.of(context).next,
            bgcolor: AppColors.primary),
      ),
    );
  }
}
