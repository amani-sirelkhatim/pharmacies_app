import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/storage/local.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/user/profile/address.dart';
import 'package:pharmacies_app/features/user/profile/personalinfo.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  void _restartApp() {
    // Schedule a frame in the next frame callback
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Exit current app
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // Delay for a short duration to ensure the app is completely closed
      Timer(Duration(seconds: 2), () {
        // Relaunch the app after a short delay
        SystemChannels.platform.invokeMethod('SystemNavigator.push');
      });
    });
  }

  int language = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.grey.withOpacity(.5))),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        push(context, const PersonalInfo());
                      },
                      child: Row(
                        children: [
                          Text(S.of(context).personalinfo,
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7))),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios,
                              color: AppColors.primary)
                        ],
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        push(context, const Address());
                      },
                      child: Row(
                        children: [
                          Text(S.of(context).deliveryaddress,
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7))),
                          const Spacer(),
                          Icon(Icons.arrow_forward_ios,
                              color: AppColors.primary)
                        ],
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
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
                                          .collection('Customer')
                                          .doc(user?.uid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return const Center(
                                              child: Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                        }

                                        var userData = snapshot.data;
                                        int newLanguage =
                                            userData?['language'] == 'Arabic'
                                                ? 1
                                                : 2;

                                        if (language != newLanguage) {
                                          language = newLanguage;
                                        }
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(S.of(context).language,
                                                style: getTitleStyle(
                                                    color: AppColors.primary)),
                                            ListTile(
                                              title: Text(S.of(context).arabic,
                                                  style: getBodyStyle(
                                                      fontSize: 15)),
                                              leading: Radio<int>(
                                                value: 1,
                                                groupValue: language,
                                                activeColor: AppColors
                                                    .primary, // Change the active radio button color here
                                                fillColor: MaterialStateProperty
                                                    .all(AppColors
                                                        .primary), // Change the fill color when selected
                                                splashRadius:
                                                    20, // Change the splash radius when clicked
                                                onChanged: (int? value) {
                                                  setState(() {
                                                    language = value!;
                                                    Navigator.of(context).pop();

                                                    try {
                                                      LocaleService.cacheData(
                                                          LocaleService
                                                              .LocaleKey,
                                                          'ar');

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Customer')
                                                          .doc(user?.uid)
                                                          .set(
                                                              {
                                                            'language':
                                                                'Arabic',
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      _restartApp();
                                                    } catch (e) {
                                                      showErrorDialog(context,
                                                          e.toString());
                                                    }
                                                    // languagetype = 'male';
                                                  });
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                S.of(context).english,
                                                style:
                                                    getBodyStyle(fontSize: 15),
                                              ),
                                              leading: Radio<int>(
                                                value: 2,
                                                groupValue: language,
                                                activeColor: AppColors
                                                    .primary, // Change the active radio button color here
                                                fillColor: MaterialStateProperty
                                                    .all(AppColors
                                                        .primary), // Change the fill color when selected
                                                splashRadius:
                                                    25, // Change the splash radius when clicked
                                                onChanged: (int? value) {
                                                  setState(() {
                                                    language = value!;
                                                    Navigator.of(context).pop();

                                                    try {
                                                      // if (language == 1) {
                                                      //   showDialog(
                                                      //       context: context,
                                                      //       builder:
                                                      //           (BuildContext
                                                      //               context) {
                                                      //         return SimpleDialog(
                                                      //           children: [
                                                      //             Column(
                                                      //               children: [
                                                      //                 Text(
                                                      //                   'the application needs to be restarted to show changes',
                                                      //                   style: getSmallStyle(
                                                      //                       color:
                                                      //                           AppColors.primary),
                                                      //                 ),
                                                      //                 Row(
                                                      //                   children: [
                                                      //                     CustomButton(
                                                      //                       text:
                                                      //                           'ok',
                                                      //                       bgcolor:
                                                      //                           AppColors.primary,
                                                      //                       onTap:
                                                      //                           () async {
                                                      //                         await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                                      //                       },
                                                      //                     )
                                                      //                   ],
                                                      //                 ),
                                                      //                 CustomButton(
                                                      //                   text:
                                                      //                       'not now',
                                                      //                   bgcolor:
                                                      //                       AppColors.grey,
                                                      //                   onTap:
                                                      //                       () {
                                                      //                     Navigator.of(context)
                                                      //                         .pop();
                                                      //                   },
                                                      //                 )
                                                      //               ],
                                                      //             )
                                                      //           ],
                                                      //         );
                                                      //       });
                                                      // }
                                                      LocaleService.cacheData(
                                                          LocaleService
                                                              .LocaleKey,
                                                          'en');

                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Customer')
                                                          .doc(user?.uid)
                                                          .set(
                                                              {
                                                            'language':
                                                                'English',
                                                          },
                                                              SetOptions(
                                                                  merge: true));
                                                      _restartApp();
                                                    } catch (e) {
                                                      showErrorDialog(context,
                                                          e.toString());
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      })
                                ],
                              );
                            });
                      },
                      child: StreamBuilder(
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
                            return userData != null &&
                                    userData['language'] != null
                                ? Row(
                                    children: [
                                      Text(S.of(context).language,
                                          style: getBodyStyle(
                                              color: AppColors.black
                                                  .withOpacity(.7))),
                                      const Gap(20),
                                      Text(
                                          userData['language'] == 'English'
                                              ? S.of(context).english
                                              : S.of(context).arabic,
                                          style: getBodyStyle(
                                              color: AppColors.primary
                                                  .withOpacity(.7))),
                                    ],
                                  )
                                : const SizedBox();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
