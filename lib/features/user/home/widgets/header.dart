import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/search.dart';

import 'package:pharmacies_app/generated/l10n.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _drugController = TextEditingController();

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
          TextFormField(
            controller: _drugController,
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              } else {
                return null;
              }
            },
            onEditingComplete: () {
              push(context, Search(drug: _drugController.text));
            },
            // controller: companycon,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),
              hintText: S.of(context).search,
              hintStyle: getSmallStyle(color: AppColors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.primary.withOpacity(.3), width: 2.0),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
