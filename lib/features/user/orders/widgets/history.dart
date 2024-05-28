import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

import 'package:pharmacies_app/features/user/orders/orderpage.dart';
import 'package:pharmacies_app/features/user/orders/widgets/ordercard.dart';
import 'package:pharmacies_app/features/user/orders/widgets/pending.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where('customerid', isEqualTo: user!.uid)
            .where('status', whereNotIn: ['pending', 'delivery']).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                S.of(context).noorders,
                style: getBodyStyle(color: AppColors.primary),
              ),
            );
          }

          var orderData = snapshot.data!.docs;

          return orderData.isNotEmpty
              ? ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var order = index < orderData.length
                        ? orderData[index].data() as Map<String, dynamic>
                        : null;
                    return order != null && order.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              push(
                                  context,
                                  OrderPage(
                                    status: order['status'],
                                    orderid: order['orderid'],
                                    pharmacyname: order['pharmacyname'],
                                  ));
                            },
                            child: OrderCard(
                              date: order['date'] ?? '',
                              deladdress: order['address'] ?? '',
                              pharmacyname: order['pharmacyname'] ?? '',
                              status: order['status'] ?? '',
                              totalprice: order['subtotal'] ?? '',
                            ))
                        : Center(
                            child: Text(
                              S.of(context).noorders,
                              style: getBodyStyle(color: AppColors.primary),
                            ),
                          );
                  },
                  separatorBuilder: (context, index) => const Gap(10),
                  itemCount: orderData.length)
              : Center(
                  child: Text(
                    S.of(context).noorders,
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                );
          ;
        });
  }
}
