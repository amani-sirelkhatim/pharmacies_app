import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';

class RequestCard extends StatefulWidget {
  const RequestCard({super.key});

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey.withOpacity(.5))),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppColors.primary,
              ),
              Gap(5),
              Text('amani sirelkhatim')
            ],
          ),
          Gap(5),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: AppColors.primary,
              ),
              Gap(5),
              Text('0999931321'),
              Gap(30),
              Icon(
                Icons.location_pin,
                color: AppColors.primary,
              ),
              Gap(5),
              Text('khartoum')
            ],
          ),
          Gap(5),
          Row(
            children: [],
          ),
          Gap(5),
          Row(
            children: [
              Icon(
                Icons.monetization_on_outlined,
                color: AppColors.primary,
              ),
              Gap(5),
              Text('2000')
            ],
          )
        ],
      ),
    );
  }
}
