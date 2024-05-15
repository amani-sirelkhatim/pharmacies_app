import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/pharmacy/home/itemspage.dart';

import 'package:pharmacies_app/features/user/home/widgets/category.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PharmacyCate extends StatefulWidget {
  const PharmacyCate({super.key});

  @override
  State<PharmacyCate> createState() => _PharmacyCateState();
}

class _PharmacyCateState extends State<PharmacyCate> {
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
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
                          ItemsGrid(
                              Cat: 'heartvasculardiseses',
                              title: S.of(context).heartvasculardiseses));
                    },
                    child: CatCard(
                        Cat: S.of(context).heartvasculardiseses,
                        image: 'assets/images/heart.jpg'),
                  ),
                ]),
          )
        ]),
      ),
    );
  }
}
