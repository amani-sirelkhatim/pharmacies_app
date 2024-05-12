import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/catigoryPage.dart';
import 'package:pharmacies_app/features/user/home/widgets/category.dart';
import 'package:pharmacies_app/generated/l10n.dart';
import 'package:intl/intl.dart';

class Cattegories extends StatefulWidget {
  const Cattegories({super.key});

  @override
  State<Cattegories> createState() => _CattegoriesState();
}

class _CattegoriesState extends State<Cattegories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 730,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(children: [
          Row(children: [
            Text(
              S.of(context).categories + " : ",
              style: getTitleStyle(color: AppColors.primary),
            )
          ]),
          Expanded(
            child: GridView(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100, // Adjust as needed
                    childAspectRatio: 1.5, //

                    crossAxisSpacing: 10,
                    mainAxisExtent: 180,
                    mainAxisSpacing: 0),
                children: [
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Antibiaotics',
                              title: S.of(context).Antibiotics));
                    },
                    child: CatCard(
                        Cat: S.of(context).Antibiotics,
                        image: 'assets/images/antibiotics.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Diabeties', title: S.of(context).diabetes));
                    },
                    child: CatCard(
                        Cat: S.of(context).diabetes,
                        image: 'assets/images/diabites.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Otorhinolaryngology',
                              title: S.of(context).Otorhinolaryngology));
                    },
                    child: CatCard(
                        Cat: S.of(context).Otorhinolaryngology,
                        image: 'assets/images/anf.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Tuberculosis',
                              title: S.of(context).tuberculosis));
                    },
                    child: CatCard(
                        Cat: S.of(context).tuberculosis,
                        image: 'assets/images/alsol.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Blooddiseases',
                              title: S.of(context).blooddiseases));
                    },
                    child: CatCard(
                        Cat: S.of(context).blooddiseases,
                        image: 'assets/images/blood.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Galanddiseases',
                              title: S.of(context).galanddiseases));
                    },
                    child: CatCard(
                        Cat: S.of(context).galanddiseases,
                        image: 'assets/images/glade.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'Immunediseases',
                              title: S.of(context).immunediseases));
                    },
                    child: CatCard(
                        Cat: S.of(context).immunediseases,
                        image: 'assets/images/immune.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'kidneydiseases',
                              title: S.of(context).kidneydiseases));
                    },
                    child: CatCard(
                        Cat: S.of(context).kidneydiseases,
                        image: 'assets/images/kidney.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'pressuredisease',
                              title: S.of(context).pressuredisease));
                    },
                    child: CatCard(
                        Cat: S.of(context).pressuredisease,
                        image: 'assets/images/pressure.jpg'),
                  ),
                  GestureDetector(
                    onTap: () {
                      push(
                          context,
                          CatPage(
                              Cat: 'heartvasculardiseses',
                              title: S.of(context).heartvasculardiseses));
                    },
                    child: CatCard(
                        Cat: S.of(context).heartvasculardiseses,
                        image: 'assets/images/heart.jpg'),
                  ),
                ]),
          )
        ]
            // Expanded(
            //     child: GridView.builder(
            //         scrollDirection: Axis.vertical,
            //         itemCount: 10,
            //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //             maxCrossAxisExtent: 110, // Adjust as needed
            //             childAspectRatio: 1.5, //

            //             crossAxisSpacing: 0,
            //             mainAxisExtent: 100,
            //             mainAxisSpacing: 10),
            //         itemBuilder: (context, index) {
            //           return Container(
            //             child: Column(
            //               children: [
            //                 ClipRRect(
            //                     borderRadius: BorderRadius.circular(20),
            //                     child: Image.asset('name')),
            //                 Text(
            //                   'name',
            //                   style: getSmallStyle(),
            //                 )
            //               ],
            //             ),
            //           );
            //         }))

            ),
      ),
    );
  }
}
