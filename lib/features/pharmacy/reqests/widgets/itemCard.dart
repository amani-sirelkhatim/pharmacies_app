import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class RequestedItemCard extends StatefulWidget {
  const RequestedItemCard(
      {super.key,
      required this.drugname,
      required this.amount,
      required this.price,
      required this.image,
      required this.perscription});
  final String drugname;
  final int amount;
  final int price;
  final String image;
  final String? perscription;

  @override
  State<RequestedItemCard> createState() => _RequestedItemCardState();
}

class _RequestedItemCardState extends State<RequestedItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.all(20),
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
                    child: Image.network(
                      widget.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 130,
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    widget.drugname,
                    style: getTitleStyle(color: AppColors.primary),
                  ),
                ),
              )
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Text(
                S.of(context).quantity + ' : ' + widget.amount.toString(),
                style: getBodyStyle(color: AppColors.primary),
              ),
              const Gap(50),
              Text(
                S.of(context).totalamount + ' : ' + widget.price.toString(),
                style: getBodyStyle(color: AppColors.primary),
              )
            ],
          ),
          const Gap(20),
          if (widget.perscription != null)
            Container(
              height: 150,
              child: FullScreenWidget(
                disposeLevel: DisposeLevel.Low,
                child: SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.perscription ?? '',
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
