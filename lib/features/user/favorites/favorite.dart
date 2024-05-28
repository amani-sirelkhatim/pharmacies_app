import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/favorites/widgets/favoriteCard.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/drugPage.dart';

import 'package:pharmacies_app/generated/l10n.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            color: AppColors.primary,
            child: Text(
              S.of(context).favorite,
              style: getTitleStyle(color: AppColors.white),
            ),
          ),

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Favorite')
                  .doc(user!.uid)
                  .collection('Favorite')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text(
                      'there are no saved products yet',
                      style: getBodyStyle(color: AppColors.primary),
                    ),
                  );
                }
                var data = snapshot.data!.docs;
                return data != null && data.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 columns
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                            ),
                            itemCount: data
                                .length, // Set the number of items you want in the grid
                            itemBuilder: (BuildContext context, int index) {
                              var item = index < data.length
                                  ? data[index].data() as Map<String, dynamic>
                                  : null;
                              return item != null
                                  ? GestureDetector(
                                      onTap: () {
                                        push(
                                            context,
                                            DrugPage(
                                              pharmacyname:
                                                  item['pharmacyname'],
                                              productid: item['productid'],
                                            ));
                                      },
                                      child: FavoriteCard(
                                        productid: item['productid'],
                                        productname: item['productname'],
                                      ))
                                  : SizedBox();
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gap(300),
                            Text(
                              S.of(context).nosaved,
                              style: getTitleStyle(color: AppColors.primary),
                            ),
                          ],
                        ),
                      );
              })
          // :
        ],
      )),
    );
  }
}
