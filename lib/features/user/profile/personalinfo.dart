import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isloading = false;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();

    bool isVisable = true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary)),
        title: Text(S.of(context).personalinfo,
            style: getTitleStyle(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Customer')
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
              _emailController.text =
                  userData['email'] != null ? userData['email'].toString() : '';
              _nameController.text =
                  userData['name'] != null ? userData['name'].toString() : '';
              _phoneController.text =
                  userData['phone'] != null ? userData['phone'].toString() : '';
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: AppColors.black),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusColor: AppColors.primary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: Text(S.of(context).name),
                          labelStyle: getBodyStyle(),
                          hintText: S.of(context).entername,
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                        ),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).entername;
                          }
                          return null;
                        },
                      ),
                      const Gap(40),
                      TextFormField(
                        style: TextStyle(color: AppColors.black),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          focusColor: AppColors.primary,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          label: Text(S.of(context).phone),
                          labelStyle: getBodyStyle(),
                          hintText: S.of(context).entername,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                        ),
                        controller: _phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).entername;
                          }
                          return null;
                        },
                      ),
                      const Gap(40),
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
                            return S.of(context).email;
                          } else if (!emailValidate(value)) {
                            return 'the email is wrong!!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Gap(20),
                      isloading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              text: S.of(context).update,
                              bgcolor: AppColors.primary,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    setState(() {
                                      isloading = true;
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Customer')
                                        .doc(user?.uid)
                                        .set({
                                      'name': _nameController.text,
                                      'email': _emailController.text,
                                      'phone': _phoneController.text
                                    }, SetOptions(merge: true));
                                  } catch (e) {
                                    showErrorDialog(context, e.toString());
                                  } finally {
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                }
                              })
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
