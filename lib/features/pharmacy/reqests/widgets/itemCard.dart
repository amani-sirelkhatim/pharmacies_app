import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class RequestedItemCard extends StatefulWidget {
  const RequestedItemCard({super.key});

  @override
  State<RequestedItemCard> createState() => _RequestedItemCardState();
}

class _RequestedItemCardState extends State<RequestedItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          border: Border.all(color: AppColors.primary.withOpacity(.3))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/panadol1.png',
                      width: 80,
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Text(
                  'name',
                  style: getTitleStyle(),
                ),
              )
            ],
          ),
          Gap(20),
          Row(
            children: [
              Text(
                S.of(context).quantity + ' : 2',
                style: getBodyStyle(color: AppColors.primary),
              ),
              Gap(50),
              Text(
                S.of(context).totalamount + ' : 2000',
                style: getBodyStyle(color: AppColors.primary),
              )
            ],
          ),
          Gap(20),
          Container(
            height: 150,
            child: FullScreenWidget(
              disposeLevel: DisposeLevel.Low,
              child: SafeArea(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/perscription.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
