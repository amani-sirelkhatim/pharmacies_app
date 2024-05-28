import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Pharmacy').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }

          var userData = snapshot.data;
          return userData != null
              ? Padding(
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
                              itemCount: userData.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          110, // Adjust as needed
                                      childAspectRatio: 1.5, //

                                      crossAxisSpacing: 0,
                                      mainAxisExtent: 100,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                var pharmacy = index < userData.docs.length
                                    ? userData.docs[index].data()
                                        as Map<String, dynamic>
                                    : null;
                                return pharmacy != null
                                    ? GestureDetector(
                                        onTap: () {
                                          push(
                                              context,
                                              PharmecyPage(
                                                Pharmacyid: pharmacy['id'],
                                                name: pharmacy['name'],
                                              ));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                      backgroundImage: pharmacy[
                                                                  'image'] ==
                                                              null
                                                          ? const AssetImage(
                                                                  'assets/images/pharpro.jpeg')
                                                              as ImageProvider<
                                                                  Object>
                                                          : NetworkImage(pharmacy[
                                                                      'image']
                                                                  as String)
                                                              as ImageProvider<
                                                                  Object>,
                                                      radius: 30,
                                                      backgroundColor:
                                                          AppColors.grey),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    pharmacy['name'],
                                                    style: getSmallStyle(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox();
                              }),
                        ))
                      ],
                    ),
                  ),
                )
              : SizedBox();
        });
  }
}
