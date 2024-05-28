import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class RequestCard extends StatefulWidget {
  const RequestCard(
      {super.key,
      required this.customerid,
      required this.orderid,
      required this.subtotal,
      required this.date,
      required this.status});
  final String customerid;
  final String orderid;
  final int subtotal;
  final String date;
  final String status;

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Customer')
            .doc(widget.customerid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }

          var userData = snapshot.data;
          return userData != null
              ? Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: AppColors.grey.withOpacity(.5))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          const Gap(5),
                          Text(userData['name'])
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                          const Gap(5),
                          Text(userData['phone']),
                          const Gap(30),
                          Icon(
                            Icons.location_pin,
                            color: AppColors.primary,
                          ),
                          const Gap(5),
                          Expanded(
                              child: Text(maxLines: 3, userData['address']))
                        ],
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            color: AppColors.primary,
                          ),
                          const Gap(5),
                          Text(widget.subtotal.toString()),
                          const Gap(20),
                          Icon(Icons.calendar_month, color: AppColors.primary),
                          const Gap(5),
                          Text(widget.date.toString()),
                        ],
                      ),
                      if (widget.status == 'done')
                        Text(
                          S.of(context).status + ' : ' + S.of(context).done,
                          style: getSmallStyle(color: AppColors.primary),
                        ),
                      if (widget.status == 'declined')
                        Text(
                          S.of(context).status + ' : ' + S.of(context).declined,
                          style: getSmallStyle(color: AppColors.primary),
                        ),
                      if (widget.status == 'pending')
                        Text(
                          S.of(context).status +
                              ' : ' +
                              S.of(context).pendingorder,
                          style: getSmallStyle(color: AppColors.primary),
                        ),
                      if (widget.status == 'delivery')
                        Text(
                          S.of(context).status + ' : ' + S.of(context).delivery,
                          style: getSmallStyle(color: AppColors.primary),
                        ),
                    ],
                  ),
                )
              : const SizedBox();
        });
  }
}
