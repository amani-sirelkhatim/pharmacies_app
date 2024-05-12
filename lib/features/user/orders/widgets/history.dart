import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';

import 'package:pharmacies_app/features/user/orders/orderpage.dart';
import 'package:pharmacies_app/features/user/orders/widgets/ordercard.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                push(context, const OrderPage());
              },
              child:const  OrderCard());
        },
        separatorBuilder: (context, index) =>const Gap(10),
        itemCount: 4);
  }
}
