import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';

import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/Cupit/AddDrugCupit.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/Cupit/AddDrugStates.dart';
import 'package:pharmacies_app/features/pharmacy/pharmacyNav.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class HowToUse extends StatefulWidget {
  const HowToUse(
      {super.key,
      required this.name,
      required this.price,
      required this.image1,
      required this.image2,
      required this.needed,
      required this.desArabic,
      required this.desEnglish,
      required this.cat});
  final String name;
  final int? price;
  final String image1;
  final String image2;
  final bool needed;
  final List desArabic;
  final List desEnglish;
  final String cat;

  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  final TextEditingController _howtouse = TextEditingController();

  List howArabic = [];
  List howEnglish = [];
  showinputdialog(int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: AppColors.white,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: AppColors.black),
                      maxLines: 2,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        focusColor: AppColors.primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: Text(type == 1
                            ? S.of(context).usearabic
                            : S.of(context).useenglish),
                        labelStyle: getBodyStyle(),
                        prefixIcon: Icon(
                          Icons.local_pharmacy_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      controller: _howtouse,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return type == 1
                              ? S.of(context).usearabic
                              : S.of(context).useenglish;
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    CustomButton(
                        onTap: () {
                          if (type == 1) {
                            setState(() {
                              howArabic.add(_howtouse.text);
                              _howtouse.clear();
                            });
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              howEnglish.add(_howtouse.text);
                              _howtouse.clear();
                            });
                            Navigator.pop(context);
                          }
                        },
                        text: S.of(context).save,
                        bgcolor: AppColors.primary)
                  ],
                ),
              ),
            ],
          );
        });
  }

  bool show = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDrugCubit, AddDrugStates>(
      listener: (context, state) {
        if (state is AddDrugSuccessState) {
          showSentAlertDialog(context,
              title: 'done',
              ok: 'ok',
              alert: 'Product Added Successfuly',
              Subtiltle: '', onTap: () {
            Navigator.pop(context);
            pushWithReplacment(context, PharmacyNav());
          });
        } else if (state is AddDrugErrorState) {
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary)),
          centerTitle: true,
          title: Text(
            S.of(context).use,
            style: getTitleStyle(color: AppColors.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.grey)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(S.of(context).usearabic + " :",
                              style: getBodyStyle(color: AppColors.black)),
                          const Gap(30),
                          IconButton(
                              onPressed: () {
                                showinputdialog(1);
                              },
                              icon: Icon(
                                Icons.add,
                                color: AppColors.primary,
                              ))
                        ],
                      ),
                      if (howArabic.isNotEmpty)
                        SizedBox(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: howArabic.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                    title: Text(
                                      howArabic[index].toString(),
                                      style:
                                          getBodyStyle(color: AppColors.black),
                                    ),
                                  );
                                }))
                    ],
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.grey)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(S.of(context).useenglish + " :",
                              style: getBodyStyle(color: AppColors.black)),
                          const Gap(30),
                          IconButton(
                              onPressed: () {
                                showinputdialog(2);
                              },
                              icon: Icon(
                                Icons.add,
                                color: AppColors.primary,
                              ))
                        ],
                      ),
                      if (howEnglish.isNotEmpty)
                        SizedBox(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: howEnglish.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                    title: Text(howEnglish[index].toString(),
                                        style: getBodyStyle()),
                                  );
                                }))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(20),
          child: CustomButton(
              onTap: () {
                if (howArabic.isNotEmpty && howEnglish.isNotEmpty) {
                  context.read<AddDrugCubit>().AddDrug(
                      pharmacyname: user!.displayName.toString(),
                      pharmacyid: user!.uid,
                      cat: widget.cat,
                      name: widget.name,
                      descriptionArabic: widget.desArabic,
                      descriptionEnglish: widget.desEnglish,
                      howtouseArabic: howArabic,
                      howtouseEnglish: howEnglish,
                      frontimage: widget.image1,
                      backimage: widget.image2,
                      price: widget.price,
                      perscription: widget.needed);
                } else {
                  showErrorDialog(context,
                      'Make sure you added both of the How to use items');
                }
              },
              style: getTitleStyle(color: AppColors.white),
              text: S.of(context).save,
              bgcolor: AppColors.primary),
        ),
      ),
    );
  }
}
