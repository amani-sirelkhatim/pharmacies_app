import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/Auth/presentation/login.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 1,
              ),
              Gap(50),
              Lottie.asset('assets/icons/welcome.json'),
              Spacer(
                flex: 1,
              ),
              Container(
                height: 380,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100))),
                child: Column(
                  children: [
                    Gap(60),
                    Text('Join us as a',
                        style: getTitleStyle(
                            color: AppColors.white, fontSize: 40)),
                    Gap(60),
                    CustomButton(
                      onTap: () {
                        push(
                            context,
                            Login(
                              type: 0,
                            ));
                      },
                      width: 250,
                      text: 'Patient',
                      bgcolor: AppColors.white,
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                    Gap(30),
                    CustomButton(
                      onTap: () {
                        push(
                            context,
                            Login(
                              type: 1,
                            ));
                      },
                      width: 250,
                      text: 'Pharmacy',
                      bgcolor: AppColors.white,
                      style: getTitleStyle(color: AppColors.primary),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
