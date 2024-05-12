import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/email_validator.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/Auth/presentation/signUp.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.type});
  final int type;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  'Lets Get you In!!',
                  style: getTitleStyle(
                      color: AppColors.black.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                Gap(10),
                Text(
                  'Welcome Back',
                  style: getBodyStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(50),
                Gap(30),
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
                      Icons.email_rounded,
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
                Gap(40),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          // push(context, forget());
                        },
                        child: Text(
                          'Forgot Password?!',
                          style: getSmallStyle(color: AppColors.primary),
                        )),
                  ],
                ),
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
                          if (widget.type == 0) {
                            pushWithReplacment(context, PatientNav());
                          }
                        },
                        width: 300,
                        text: 'Login',
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
            'dont have an account?',
            style: getSmallStyle(color: AppColors.grey),
          ),
          TextButton(
              onPressed: () {
                pushWithReplacment(context, SignUp(type: widget.type));
              },
              child: Text(
                'Regestir now',
                style: getSmallStyle(color: AppColors.primary),
              ))
        ],
      ),
    );
  }
}
