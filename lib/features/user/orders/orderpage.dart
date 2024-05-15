import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

import 'package:pharmacies_app/generated/l10n.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary)),
          centerTitle: true,
          title: Text(
            'اسم الصيدلية',
            style: getTitleStyle(color: AppColors.primary),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.circle,
                                  color: AppColors.primary.withOpacity(.5),
                                  size: 10,
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text(
                                        'اسم الدواء',
                                        style: getTitleStyle(),
                                      ),
                                      Text(
                                        '100',
                                        style: getBodyStyle(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Text('*2'),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: AppColors.grey.withOpacity(.5),
                        ),
                    itemCount: 3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).PaymentSumary,
                        style: getTitleStyle(color: AppColors.primary)),
                    const Gap(20),
                    Row(
                      children: [
                        Text(S.of(context).subtotal,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        const Spacer(),
                        Text('200',
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7)))
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(S.of(context).deliveryfee,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        const Spacer(),
                        Text('200',
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7)))
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(S.of(context).Servicefee,
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7))),
                        const Spacer(),
                        Text('200',
                            style: getBodyStyle(
                                color: AppColors.black.withOpacity(.7)))
                      ],
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Text(S.of(context).totalamount,
                            style: getTitleStyle(color: AppColors.primary)),
                        const Spacer(),
                        Text(
                          '200',
                          style: getTitleStyle(color: AppColors.primary),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
