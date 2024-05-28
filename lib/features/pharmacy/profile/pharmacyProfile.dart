import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/core/widgets/map.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PharmacyProfile extends StatefulWidget {
  const PharmacyProfile({super.key});

  @override
  State<PharmacyProfile> createState() => _PharmacyProfileState();
}

class _PharmacyProfileState extends State<PharmacyProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();
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

  update(int type, String name, String address, String email, String phone) {
    if (type == 1) {
      try {
        FirebaseFirestore.instance.collection('Pharmacy').doc(user?.uid).set({
          'name': name,
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok:S.of(context).ok,
            alert: S.of(context).updated,
            Subtiltle: '', onTap: () {
          Navigator.pop(context);
        });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    } else if (type == 2) {
      try {
        FirebaseFirestore.instance.collection('Pharmacy').doc(user?.uid).set({
          'email': email,
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok: S.of(context).ok,
            alert: S.of(context).updated,
            Subtiltle: '', onTap: () {
          Navigator.pop(context);
        });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    } else if (type == 3) {
      try {
        push(context, MapTest(id: user!.uid, type: 2));
        // FirebaseFirestore.instance.collection('Pharmacy').doc(user?.uid).set({
        //   'address': address,
        // }, SetOptions(merge: true));
        // showSentAlertDialog(context,
        //     title: 'done',
        //     ok: 'ok',
        //     alert: 'Updated Successfuly',
        //     Subtiltle: '', onTap: () {
        //   Navigator.pop(context);
        // });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    } else {
      try {
        FirebaseFirestore.instance.collection('Pharmacy').doc(user?.uid).set({
          'phone': phone,
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok: S.of(context).ok,
            alert: S.of(context).updated,
            Subtiltle: '', onTap: () {
          Navigator.pop(context);
        });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    }
  }

  int? language;

  late String image;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pharmacy-1a87c.appspot.com');
  Future<String> uploadImageToFireStore(File image) async {
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      String imagePath = 'Pharmacy/${_auth.currentUser!.uid}/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      await addImageToFirestore(imageUrl: url);

      return url;
    } catch (e) {
      print('Error during image upload to Firestore: $e');
      return '';
    }
  }

  Future<void> addImageToFirestore({required String imageUrl}) async {
    try {
      final CollectionReference imageCollection =
          FirebaseFirestore.instance.collection('Pharmacy');

      await imageCollection.doc(user!.uid).set({
        'image': imageUrl,
      }, SetOptions(merge: true));

      print('Image added to Firestore: $imageUrl');
    } catch (e) {
      print('Error adding image to Firestore: $e');
    }
  }

  Future<void> _showUploadoptions() async {
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
                final imageUrl = await uploadImageToFireStore(file!);
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
                final imageUrl = await uploadImageToFireStore(file!);
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

  showEditDialog(int type) {
    if (type == 5) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Pharmacy')
                        .doc(user?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ));
                      }

                      var userData = snapshot.data;
                      int newLanguage =
                          userData?['language'] == 'Arabic' ? 1 : 2;

                      if (language != newLanguage) {
                        language = newLanguage;
                      }
                      return userData != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(S.of(context).language,
                                    style: getTitleStyle(
                                        color: AppColors.primary)),
                                ListTile(
                                  title: Text(S.of(context).arabic,
                                      style: getBodyStyle(fontSize: 15)),
                                  leading: Radio<int>(
                                    value: 1,
                                    groupValue: language,
                                    activeColor: AppColors
                                        .primary, // Change the active radio button color here
                                    fillColor: MaterialStateProperty.all(AppColors
                                        .primary), // Change the fill color when selected
                                    splashRadius:
                                        20, // Change the splash radius when clicked
                                    onChanged: (int? value) {
                                      setState(() {
                                        language = value!;
                                        Navigator.of(context).pop();
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Pharmacy')
                                              .doc(user?.uid)
                                              .set({
                                            'language': 'Arabic',
                                          }, SetOptions(merge: true));
                                        } catch (e) {
                                          showErrorDialog(
                                              context, e.toString());
                                        }
                                        // languagetype = 'male';
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    S.of(context).english,
                                    style: getBodyStyle(fontSize: 15),
                                  ),
                                  leading: Radio<int>(
                                    value: 2,
                                    groupValue: language,
                                    activeColor: AppColors
                                        .primary, // Change the active radio button color here
                                    fillColor: MaterialStateProperty.all(AppColors
                                        .primary), // Change the fill color when selected
                                    splashRadius:
                                        25, // Change the splash radius when clicked
                                    onChanged: (int? value) {
                                      setState(() {
                                        language = value!;
                                        Navigator.of(context).pop();

                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Pharmacy')
                                              .doc(user?.uid)
                                              .set({
                                            'language': 'English',
                                          }, SetOptions(merge: true));
                                        } catch (e) {
                                          showErrorDialog(
                                              context, e.toString());
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox();
                    })
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Pharmacy')
                          .doc(user?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: Center(
                            child: CircularProgressIndicator(),
                          ));
                        }

                        var userData = snapshot.data;
                        if (userData != null) {
                          _nameController.text = userData['name'] != null
                              ? userData['name'].toString()
                              : '';
                          _emailController.text = userData['email'] != null
                              ? userData['email'].toString()
                              : '';
                          _addressController.text = userData['address'] != null
                              ? userData['address'].toString()
                              : '';
                          _PhoneController.text = userData['phone'] != null
                              ? userData['phone'].toString()
                              : '';
                        }
                        return userData != null
                            ? Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    if (type == 1)
                                      TextFormField(
                                        controller: _nameController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label:
                                              Text(S.of(context).pharmacyname),
                                          labelStyle: getBodyStyle(),
                                          prefixIcon: Icon(
                                            Icons.medical_information_outlined,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        // controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S.of(context).pharmacyname;
                                          }
                                          return null;
                                        },
                                      ),
                                    if (type == 2)
                                      TextFormField(
                                        controller: _emailController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label: Text(S.of(context).email),
                                          labelStyle: getBodyStyle(),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        // controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S.of(context).email;
                                          }
                                          return null;
                                        },
                                      ),
                                    if (type == 3)
                                      TextFormField(
                                        maxLines: 3,
                                        enabled: false,
                                        controller: _addressController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label: Text(S.of(context).address),
                                          labelStyle: getBodyStyle(),
                                          prefixIcon: Icon(
                                            Icons.location_pin,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        // controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S.of(context).address;
                                          }
                                          return null;
                                        },
                                      ),
                                    if (type == 4)
                                      TextFormField(
                                        controller: _PhoneController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label: Text(S.of(context).phone),
                                          labelStyle: getBodyStyle(),
                                          prefixIcon: Icon(
                                            Icons.location_pin,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        // controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S.of(context).address;
                                          }
                                          return null;
                                        },
                                      ),
                                    const Gap(20),
                                    CustomButton(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            update(
                                                type,
                                                _nameController.text,
                                                _addressController.text,
                                                _emailController.text,
                                                _PhoneController.text);
                                          }
                                        },
                                        text: S.of(context).save,
                                        bgcolor: AppColors.primary)
                                  ],
                                ),
                              )
                            : const SizedBox();
                      }),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Pharmacy')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }

                var userData = snapshot.data;
                return userData != null
                    ? Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 50,
                            color: AppColors.primary,
                            child: Text(
                              S.of(context).profile,
                              style: getTitleStyle(color: AppColors.white),
                            ),
                          ),
                          const Gap(20),
                          Stack(alignment: Alignment.bottomRight, children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundImage: userData['image'] == null
                                    ? const AssetImage(
                                            'assets/images/pharpro.jpeg')
                                        as ImageProvider<Object>
                                    : NetworkImage(userData['image'] as String)
                                        as ImageProvider<Object>),
                            Positioned(
                              right: -12,
                              child: IconButton(
                                  onPressed: () {
                                    _showUploadoptions();
                                  },
                                  icon: Icon(Icons.camera_alt,
                                      color: AppColors.primary)),
                            )
                          ]),
                          const Gap(40),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.grey.withOpacity(.5))),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.medical_information_outlined,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        flex: 2,
                                        child: Text(userData['name'],
                                            style: getBodyStyle()),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(1);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.primary,
                                          ))
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        flex: 2,
                                        child: Text(userData['email'],
                                            style: getBodyStyle()),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(2);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.primary,
                                          ))
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        flex: 2,
                                        child: Text(userData['phone'],
                                            style: getBodyStyle()),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(4);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.primary,
                                          ))
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                            maxLines: 3,
                                            userData['address'],
                                            style: getBodyStyle()),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(3);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.primary,
                                          ))
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                            userData['language'] == 'Arabic'
                                                ? S.of(context).arabic
                                                : S.of(context).english,
                                            style: getBodyStyle()),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(5);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: AppColors.primary,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : const SizedBox();
              }),
        ),
      ),
    );
  }
}
