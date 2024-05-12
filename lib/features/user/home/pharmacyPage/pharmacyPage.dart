import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/catigoryPage.dart';
import 'package:pharmacies_app/features/user/home/widgets/category.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PharmecyPage extends StatefulWidget {
  const PharmecyPage({super.key, required this.name});
  final String name;

  @override
  State<PharmecyPage> createState() => _PharmecyPageState();
}

class _PharmecyPageState extends State<PharmecyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary)),
        centerTitle: true,
        title: Text(
          widget.name,
          style: getTitleStyle(color: AppColors.primary),
        ),
      ),
      body: SizedBox(
        height: 800,
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
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100, // Adjust as needed
                      childAspectRatio: 1.5, //

                      crossAxisSpacing: 10,
                      mainAxisExtent: 170,
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
                                Cat: 'Diabeties',
                                title: S.of(context).diabetes));
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
          ]),
        ),
      ),
    );
  }
}
