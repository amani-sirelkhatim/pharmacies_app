import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';

import 'package:pharmacies_app/features/pharmacy/reqests/widgets/itemCard.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({super.key});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary)),
            centerTitle: true,
            title: Text(
              S.of(context).order,
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
                      physics:const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const Padding(
                            padding:  EdgeInsets.only(top: 10.0),
                            child: RequestedItemCard());
                      },
                      separatorBuilder: (context, index) => Gap(1),
                      itemCount: 3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding:const EdgeInsets.all(10),
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
                       const   Spacer(),
                          Text('200',
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7)))
                        ],
                      ),
                  const    Gap(10),
                      Row(
                        children: [
                          Text(S.of(context).deliveryfee,
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7))),
                      const    Spacer(),
                          Text('200',
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7)))
                        ],
                      ),
                 const     Gap(10),
                      Row(
                        children: [
                          Text(S.of(context).Servicefee,
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7))),
                      const    Spacer(),
                          Text('200',
                              style: getBodyStyle(
                                  color: AppColors.black.withOpacity(.7)))
                        ],
                      ),
                   const   Gap(10),
                      Row(
                        children: [
                          Text(S.of(context).totalamount,
                              style: getTitleStyle(color: AppColors.primary)),
                     const     Spacer(),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: CustomButton(
                      style: getTitleStyle(color: AppColors.white),
                      text: S.of(context).accept,
                      bgcolor: AppColors.primary),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: CustomButton(
                      style: getTitleStyle(color: AppColors.white),
                      text: S.of(context).decline,
                      bgcolor: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
