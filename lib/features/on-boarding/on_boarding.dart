import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/storage/local.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/on-boarding/boarding_model.dart';
import 'package:pharmacies_app/features/on-boarding/welcome_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  int currentpage = 0;
  var pagecontroler = PageController();
  List<boardingModel> pages = [
    boardingModel(
        image: 'assets/images/searchpills.jpg',
        title: 'Search For your needs in an easier and More effective way'),
    boardingModel(
        image: 'assets/images/Medical prescription-bro.png',
        title: 'Uploud your Prescription and order your Medecine'),
    boardingModel(
        image: 'assets/images/Delivery-bro.png',
        title: 'On-Time Delivery, Every Time'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                LocaleService.cacheData(LocaleService.Is_opened, true);

                pushWithReplacment(context, welcome());
              },
              child: Text(
                'Skip',
                style: getTitleStyle(color: AppColors.primary),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                });
              },
              controller: pagecontroler,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      pages[index].image,
                      height: 400,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      pages[index].title,
                      style:
                          getTitleStyle(color: AppColors.primary, fontSize: 20),
                    ),
                  ],
                );
              },
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  SmoothPageIndicator(
                      effect: WormEffect(
                          activeDotColor: AppColors.primary,
                          dotColor: AppColors.grey,
                          dotHeight: 12,
                          dotWidth: 20),
                      controller: pagecontroler,
                      count: 3),
                  Spacer(),
                  if (currentpage == 2)
                    CustomButton(
                      bgcolor: AppColors.primary,
                      width: 100,
                      onTap: () {
                        LocaleService.cacheData(LocaleService.Is_opened, true);

                        pushWithReplacment(context, welcome());
                      },
                      text: 'Lets Start',
                      style: getBodyStyle(
                          color: AppColors.lightblue,
                          fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
