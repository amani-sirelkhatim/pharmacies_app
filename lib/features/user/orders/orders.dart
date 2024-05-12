import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/orders/cart.dart';
import 'package:pharmacies_app/features/user/orders/widgets/history.dart';
import 'package:pharmacies_app/features/user/orders/widgets/pending.dart';
import 'package:pharmacies_app/generated/l10n.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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
            Gap(30),
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
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                setState(() {
                  page = v;
                  print(page);
                });
              },
            ),
            page == 1
                ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0), child: Pending()),
                  )
                : Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0), child: History()),
                  ),
            if (status == true)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary),
                      child: IconButton(
                          onPressed: () {
                            push(context, Details());
                          },
                          icon: Icon(
                            Icons.shopping_cart_checkout_rounded,
                            color: AppColors.white,
                          )),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
