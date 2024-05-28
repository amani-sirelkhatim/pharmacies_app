import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/RequestHistory.dart';
import 'package:pharmacies_app/features/pharmacy/reqests/widgets/pendingRequests.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  bool status = true;
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              color: AppColors.primary,
              child: Text(
                S.of(context).orders,
                style: getTitleStyle(color: AppColors.white),
              ),
            ),
            const Gap(30),
            CustomSlidingSegmentedControl<int>(
              initialValue: 1,
              children: {
                1: Text(S.of(context).pending),
                2: Text(S.of(context).history),
              },
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(.5),
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                setState(() {
                  page = v;
                });
              },
            ),
            page == 1
                ? const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(20.0), child: PendingRequsts()),
                  )
                : const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(20.0), child: RequestHistory()),
                  ),
          ],
        ),
      ),
    );
  }
}
