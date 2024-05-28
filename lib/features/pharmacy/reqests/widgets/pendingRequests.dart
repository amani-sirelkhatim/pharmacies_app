import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/RequestDetails.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/requestCard.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PendingRequsts extends StatefulWidget {
  const PendingRequsts({super.key});

  @override
  State<PendingRequsts> createState() => _PendingRequstsState();
}

class _PendingRequstsState extends State<PendingRequsts> {
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
            .where('pharmacyId', isEqualTo: user!.uid)
            .where('status', whereIn: ['pending', 'delivery']).snapshots(),
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
                  itemBuilder: (context, index) {
                    var order = index < orderData.length
                        ? orderData[index].data() as Map<String, dynamic>
                        : null;
                    return order != null
                        ? GestureDetector(
                            onTap: () {
                              push(
                                  context,
                                  RequestDetails(
                                    status: order['status'],
                                    orderid: order['orderid'],
                                  ));
                            },
                            child: RequestCard(
                              status: order['status'],
                              customerid: order['customerid'],
                              orderid: order['orderid'],
                              subtotal: order['subtotal'],
                              date: order['date'].toString(),
                            ))
                        : const SizedBox();
                  },
                  separatorBuilder: (context, index) => const Gap(10),
                  itemCount: orderData.length)
              : Center(
                  child: Text(
                    S.of(context).noorders,
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                );
        });
  }
}
