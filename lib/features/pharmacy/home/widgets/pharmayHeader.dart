import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PharmacyHeader extends StatefulWidget {
  const PharmacyHeader({super.key});

  @override
  State<PharmacyHeader> createState() => _PharmacyHeaderState();
}

class _PharmacyHeaderState extends State<PharmacyHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/pharmacy.png',
              ),
              Text(
                S.of(context).appname,
                style: getTitleStyle(color: AppColors.primary),
              )
            ],
          ),
        ],
      ),
    );
  }
}
