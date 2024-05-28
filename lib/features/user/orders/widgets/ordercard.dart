import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class OrderCard extends StatefulWidget {
  const OrderCard(
      {super.key,
      required this.pharmacyname,
      required this.deladdress,
      required this.status,
      required this.totalprice,
      required this.date});
  final String pharmacyname;
  final String deladdress;
  final String status;
  final int totalprice;
  final String date;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  TextDirection _getTextDirection() {
    if (S.of(context).language == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary.withOpacity(.1)),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pharmacyname,
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                  const Gap(5),
                  const Gap(5),
                  if (widget.status == 'done')
                    Text(
                      S.of(context).status + ' : ' + S.of(context).done,
                      style: getBodyStyle(),
                    ),
                  if (widget.status == 'declined')
                    Text(
                      S.of(context).status + ' : ' + S.of(context).declined,
                      style: getBodyStyle(),
                    ),
                  if (widget.status == 'pending')
                    Text(
                      S.of(context).status + ' : ' + S.of(context).pendingorder,
                      style: getBodyStyle(),
                    ),
                  if (widget.status == 'delivery')
                    Text(
                      S.of(context).status + ' : ' + S.of(context).delivery,
                      style: getBodyStyle(),
                    ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month, color: AppColors.primary),
                      Gap(5),
                      Text(
                        textDirection: _getTextDirection(),
                        widget.date,
                        style: getBodyStyle(),
                      )
                    ],
                  ),
                  if (widget.status == 'declined')
                    Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            S.of(context).reasons,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: AppColors.primary,
                        ),
                        const Gap(5),
                        Text(widget.totalprice.toString(),
                            style: getBodyStyle()),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
