import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/pharmacyPage/pharmacyPage.dart';

import 'package:pharmacies_app/generated/l10n.dart';

class PharmaciesList extends StatefulWidget {
  const PharmaciesList({super.key});

  @override
  State<PharmaciesList> createState() => _PharmaciesListState();
}

class _PharmaciesListState extends State<PharmaciesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: SizedBox(
        height: 230,
        child: Column(
          children: [
            Gap(10),
            Row(children: [
              Text(
                S.of(context).pharmacies + " : ",
                style: getTitleStyle(color: AppColors.primary),
              )
            ]),
            Gap(10),
            Expanded(
                child: SizedBox(
              //height: 200,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 110, // Adjust as needed
                      childAspectRatio: 1.5, //

                      crossAxisSpacing: 0,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        push(
                            context,
                            PharmecyPage(
                              name: 'العزبي',
                            ));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/phar.png'),
                                radius: 30,
                                backgroundColor: AppColors.grey),
                            Gap(10),
                            Text(
                              'العزبي',
                              style: getSmallStyle(),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
