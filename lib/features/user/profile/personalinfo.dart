import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    bool isVisable = true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary)),
        title: Text(S.of(context).personalinfo,
            style: getTitleStyle(color: AppColors.primary)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: AppColors.black),
                obscureText: isVisable,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  focusColor: AppColors.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text(S.of(context).name),
                  labelStyle: getBodyStyle(),
                  hintText: S.of(context).entername,
                  prefixIcon: Icon(
                    Icons.person,
                    color: AppColors.primary,
                  ),
                ),
                // controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).entername;
                  }
                  return null;
                },
              ),
              const Gap(40),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  label: Text(S.of(context).email),
                  labelStyle: getBodyStyle(),
                  hintText: S.of(context).enteremail,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: AppColors.primary,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return S.of(context).email;
                  } else if (!emailValidate(value)) {
                    return 'the email is wrong!!';
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20),
              CustomButton(
                text: S.of(context).update,
                bgcolor: AppColors.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
