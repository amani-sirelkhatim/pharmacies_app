import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/Auth/presentation/login.dart';

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

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Register Now !',
                  style: getTitleStyle(
                      color: AppColors.black.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                const Gap(10),
                Text(
                  'Enter your inormation below',
                  style: getBodyStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(80),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    label: widget.type == 0
                        ? Text('Full Name')
                        : Text('Pharmacy Name'),
                    labelStyle: getBodyStyle(),
                    hintText: 'Enter the name',
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
                      return 'Please enter your name';
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
                    label: Text('Email'),
                    labelStyle: getBodyStyle(),
                    hintText: 'Enter Your Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailValidate(value)) {
                      return 'the email is wrong!!';
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
                    label: Text('Address'),
                    labelStyle: getBodyStyle(),
                    hintText: 'Enter Your Address',
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: AppColors.primary,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    } else {
                      return null;
                    }
                  },
                ),
                Gap(10),
                TextFormField(
                  style: TextStyle(color: AppColors.black),
                  obscureText: isVisable,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    focusColor: AppColors.primary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    label: Text('Password'),
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
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) return 'please enter your password';
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
                          // if (_formKey.currentState!.validate()) {
                          //   context.read<AuthCubit>().login(
                          //       email: _emailController.text,
                          //       password: _passwordController.text);
                          // }
                        },
                        width: 300,
                        text: 'Sign Up',
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
            'Already have an account?',
            style: getSmallStyle(color: AppColors.grey),
          ),
          TextButton(
              onPressed: () {
                pushWithReplacment(context, Login(type: widget.type));
              },
              child: Text(
                'Login now',
                style: getSmallStyle(color: AppColors.primary),
              ))
        ],
      ),
    );
  }
}