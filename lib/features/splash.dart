import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:lottie/lottie.dart';
import 'package:pharmacies_app/core/storage/local.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/on-boarding/on_boarding.dart';
import 'package:pharmacies_app/features/on-boarding/welcome_view.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool? isopened;
  @override
  void initState() {
    super.initState();
    LocaleService.getCachedData(LocaleService.Is_opened).then((value) {
      isopened = value ?? false;
    });
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              isopened! ? const welcome() : const onBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/logo.json'),
            const Gap(50),
            Text(
              S.of(context).appname,
              style: getTitleStyle(color: AppColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
