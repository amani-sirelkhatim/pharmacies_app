import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/RequestDetails.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/requestCard.dart';

class PendingRequsts extends StatefulWidget {
  const PendingRequsts({super.key});

  @override
  State<PendingRequsts> createState() => _PendingRequstsState();
}

class _PendingRequstsState extends State<PendingRequsts> {
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
