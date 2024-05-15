import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/RequestDetails.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/requestCard.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({super.key});

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                push(context, const RequestDetails());
              },
              child: const RequestCard());
        },
        separatorBuilder: (context, index) => const Gap(10),
        itemCount: 3);
  }
}
