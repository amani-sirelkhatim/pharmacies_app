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

class RequestHistory extends StatefulWidget {
  const RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
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
            .where('status', whereNotIn: ['pending', 'delivery']).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            // print("No data available");
            return Center(
              child: Text(
                 S.of(context).noorders,
                style: getBodyStyle(color: AppColors.primary),
              ),
            );
          }
          var orderData = snapshot.data!.docs;
          return orderData.isNotEmpty && orderData != null
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
                                      orderid: order['orderid']));
                            },
                            child: RequestCard(
                                status: order['status'],
                                date: order['date'].toString(),
                                customerid: order['customerid'],
                                orderid: order['orderid'],
                                subtotal: order['subtotal']))
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
