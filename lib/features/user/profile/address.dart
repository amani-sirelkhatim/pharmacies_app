import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';

import 'package:pharmacies_app/core/widgets/map.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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
    final TextEditingController _addressController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary)),
          title: Text(S.of(context).deliveryaddress,
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
                _addressController.text = userData['address'] != null
                    ? userData['address'].toString()
                    : '';
              }
              return userData != null
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: [
                        TextFormField(
                          maxLines: 3,
                          enabled: false,
                          style: TextStyle(color: AppColors.black),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            focusColor: AppColors.primary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            label: Text(S.of(context).address),
                            labelStyle: getBodyStyle(),
                            hintText: S.of(context).enteraddress,
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                            ),
                          ),
                          controller: _addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).enteraddress;
                            }
                            return null;
                          },
                        ),
                        const Gap(20),
                        isloading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: userData['address'] == null
                                    ? S.of(context).setaddress
                                    : S.of(context).update,
                                bgcolor: AppColors.primary,
                                onTap: () async {
                                  try {
                                    setState(() {
                                      isloading = true;
                                    });
                                    push(
                                        context,
                                        MapTest(
                                          id: user!.uid,
                                          type: 1,
                                        ));
                                  } catch (e) {
                                    showErrorDialog(context, e.toString());
                                  } finally {
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                })
                      ]),
                    )
                  : const SizedBox();
            }));
  }
}
