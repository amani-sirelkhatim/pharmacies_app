import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/profile/address.dart';
import 'package:pharmacies_app/features/user/profile/personalinfo.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            Gap(20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      push(context, PersonalInfo());
                    },
                    child: Row(
                      children: [
                        Text(S.of(context).personalinfo,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: AppColors.primary)
                      ],
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      push(context, Address());
                    },
                    child: Row(
                      children: [
                        Text(S.of(context).deliveryaddress,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: AppColors.primary)
                      ],
                    ),
                  ),
                  Gap(20),
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
                                Column(
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
                                        fillColor: MaterialStateProperty.all(
                                            AppColors
                                                .primary), // Change the fill color when selected
                                        splashRadius:
                                            20, // Change the splash radius when clicked
                                        onChanged: (int? value) {
                                          setState(() {
                                            language = value!;
                                            Navigator.of(context).pop();
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
                                        fillColor: MaterialStateProperty.all(
                                            AppColors
                                                .primary), // Change the fill color when selected
                                        splashRadius:
                                            25, // Change the splash radius when clicked
                                        onChanged: (int? value) {
                                          setState(() {
                                            language = value!;
                                            Navigator.of(context).pop();
                                            //   languagetype = 'female';
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Text(S.of(context).language,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        Gap(20),
                        Text('language',
                            style: getBodyStyle(
                                color: AppColors.primary.withOpacity(.7))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
