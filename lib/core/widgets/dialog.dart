import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';

import 'package:lottie/lottie.dart';

showErrorDialog(context, errorText) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(10),
      content: Text(errorText)));
}

// loading
showLoadingDialog(BuildContext context) {
  //------------ Using Custom Loading for IOS & Android

  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.7),
    context: context,
    builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/icons/loading.json', width: 150, height: 150),
        ],
      );
    },
  );
}

showSentAlertDialog(BuildContext context,
    {String? ok,
    String? no,
    required String title,
    void Function()? onTap,
    required String alert,
    required String Subtiltle}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.grey,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.grey, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (ok != null)
                      Container(
                        width: 280,
                        height: 400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.white),
                        child: Column(
                          children: [
                            const Gap(50),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundColor:
                                      AppColors.primary.withOpacity(.2),
                                ),
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: AppColors.primary,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.white,
                                    child: Icon(
                                      Icons.done_outline_rounded,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(30),
                            Text(
                              textAlign: TextAlign.center,
                              alert,
                              style: getTitleStyle(),
                            ),
                            const Gap(15),
                            Text(
                              Subtiltle,
                              style: getBodyStyle(color: AppColors.grey),
                            ),
                            const Gap(30),
                            CustomButton(
                                onTap: onTap,
                                text: ok,
                                bgcolor: AppColors.primary,
                                style: getBodyStyle(color: AppColors.white),
                                width: 200)
                          ],
                        ),
                      ),
                    if (no != null)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primary),
                          child: Text(
                            no,
                            style: getBodyStyle(color: AppColors.black),
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
