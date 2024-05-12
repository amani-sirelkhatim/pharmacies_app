import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int amount = 1;
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
            Container(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int price = 10;
                    int total = price * amount;
                    print(total);
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      'اسم الدواء',
                                      style: getTitleStyle(),
                                    ),
                                    Spacer(),
                                    Text(
                                      total.toString(),
                                      style: getBodyStyle(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                        'assets/images/panadol1.png'),
                                  ),
                                  Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              amount = amount + 1;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.primary,
                                            ),
                                            width: 40,
                                            height: 30,
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                        Text(amount.toString()),
                                        GestureDetector(
                                          onTap: () {
                                            if (amount > 1) {
                                              setState(() {
                                                amount = amount - 1;
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.primary,
                                            ),
                                            width: 40,
                                            height: 30,
                                            child: Icon(
                                              amount > 1
                                                  ? Icons.remove
                                                  : Icons.delete,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 4),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomButton(
                  style: getTitleStyle(color: AppColors.primary),
                  text: S.of(context).addmore,
                  bgcolor: AppColors.grey),
            ),
            Expanded(
              child: CustomButton(
                  style: getTitleStyle(color: AppColors.white),
                  text: S.of(context).Checkout,
                  bgcolor: AppColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
