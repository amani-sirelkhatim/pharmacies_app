import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';

import 'package:pharmacies_app/features/user/orders/orderpage.dart';
import 'package:pharmacies_app/features/user/orders/widgets/ordercard.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                push(context, const OrderPage());
              },
              child: OrderCard());
        },
        separatorBuilder: (context, index) => Gap(10),
        itemCount: 3);
  }
}
