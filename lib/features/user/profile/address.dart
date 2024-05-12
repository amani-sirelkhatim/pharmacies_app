import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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
          title: Text(S.of(context).deliveryaddress,
              style: getTitleStyle(color: AppColors.primary)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
              style: TextStyle(color: AppColors.black),

              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                focusColor: AppColors.primary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                label: Text(S.of(context).address),
                labelStyle: getBodyStyle(),
                hintText: S.of(context).enteraddress,
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                ),
              ),
              // controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return S.of(context).enteraddress;
                }
                return null;
              },
            ),
            Gap(20),
            CustomButton(
              text: S.of(context).update,
              bgcolor: AppColors.primary,
            )
          ]),
        ));
  }
}
