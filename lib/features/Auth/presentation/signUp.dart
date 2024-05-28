import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/Auth/Cupit/AuthCupit.dart';
import 'package:pharmacies_app/features/Auth/Cupit/AuthStates.dart';
import 'package:pharmacies_app/features/Auth/presentation/login.dart';
import 'package:pharmacies_app/features/pharmacy/pharmacyNav.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.type});
  final int type;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (widget.type == 0) {
            pushWithReplacment(context, PatientNav());
          } else {
            pushWithReplacment(context, PharmacyNav());
          }
        } else if (state is RegisterErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(100),
                  Text(
                    S.of(context).regester,
                    style: getTitleStyle(
                        color: AppColors.black.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const Gap(10),
                  Text(
                    S.of(context).info,
                    style: getBodyStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(80),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: widget.type == 0
                          ? Text(S.of(context).name)
                          : Text(S.of(context).pharname),
                      labelStyle: getBodyStyle(),
                      hintText: S.of(context).entername,
                      prefixIcon: Icon(
                        widget.type == 0
                            ? Icons.person_2_outlined
                            : Icons.local_pharmacy_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).entername;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(10),
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
                        Icons.email_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).enteremail;
                      } else if (!emailValidate(value)) {
                        return S.of(context).wrongemail;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(10),
                  // TextFormField(
                  //   keyboardType: TextInputType.name,
                  //   controller: _addressController,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(25),
                  //     ),
                  //     label: Text(S.of(context).address),
                  //     labelStyle: getBodyStyle(),
                  //     hintText: S.of(context).enteraddress,
                  //     prefixIcon: Icon(
                  //       Icons.location_pin,
                  //       color: AppColors.primary,
                  //     ),
                  //   ),
                  //   textInputAction: TextInputAction.next,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return S.of(context).enteraddress;
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  Gap(10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _PhoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(S.of(context).phone),
                      labelStyle: getBodyStyle(),
                      hintText: S.of(context).enterphone,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.primary,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).enterphone;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(10),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: AppColors.black),
                    obscureText: isVisable,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      focusColor: AppColors.primary,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(S.of(context).password),
                      labelStyle: getBodyStyle(),
                      hintText: '********',
                      suffixIcon: IconButton(
                          color: AppColors.primary,
                          onPressed: () {
                            setState(() {
                              isVisable = !isVisable;
                            });
                          },
                          icon: Icon((isVisable)
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_rounded)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return S.of(context).enterpassword;
                      return null;
                    },
                  ),
                  Gap(10),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.type == 0) {
                                context.read<AuthCubit>().regestirCustomer(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    phone: _PhoneController.text);
                              } else {
                                context.read<AuthCubit>().registerPharmacy(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    phone: _PhoneController.text);
                              }
                            }
                          },
                          width: 300,
                          text: S.of(context).signup,
                          bgcolor: AppColors.primary.withOpacity(.7)),
                    ],
                  ),
                  Gap(20),
                  Gap(60),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).already,
              style: getSmallStyle(color: AppColors.grey),
            ),
            TextButton(
                onPressed: () {
                  pushWithReplacment(context, Login(type: widget.type));
                },
                child: Text(
                  S.of(context).login,
                  style: getSmallStyle(color: AppColors.primary),
                ))
          ],
        ),
      ),
    );
  }
}
