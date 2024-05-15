import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/view/howtouse.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Description extends StatefulWidget {
  const Description(
      {super.key,
      required this.name,
      required this.price,
      required this.image1,
      required this.image2,
      required this.needed,
      required this.cat});
  final String name;
  final String price;
  final String image1;
  final String image2;
  final bool needed;
  final String cat;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final TextEditingController _des = TextEditingController();

  List desArabic = [];
  List desEnglish = [];
  bool show = true;
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
                            ? S.of(context).descriptionarabic
                            : S.of(context).descriptionenglish),
                        labelStyle: getBodyStyle(),
                        prefixIcon: Icon(
                          Icons.local_pharmacy_outlined,
                          color: AppColors.primary,
                        ),
                      ),
                      controller: _des,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return type == 1
                              ? S.of(context).descriptionarabic
                              : S.of(context).descriptionenglish;
                        }
                        return null;
                      },
                    ),
                    const Gap(20),
                    CustomButton(
                        onTap: () {
                          if (type == 1) {
                            setState(() {
                              desArabic.add(_des.text);
                              _des.clear();
                            });
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              desEnglish.add(_des.text);
                              _des.clear();
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
        centerTitle: true,
        title: Text(
          S.of(context).description,
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
                        Text(S.of(context).descriptionarabic + " :",
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
                    if (desArabic.isNotEmpty)
                      SizedBox(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: desArabic.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.grey,
                                  ),
                                  title: Text(
                                    desArabic[index].toString(),
                                    style: getBodyStyle(color: AppColors.black),
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
                        Text(S.of(context).descriptionenglish + " :",
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
                    if (desEnglish.isNotEmpty)
                      SizedBox(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: desEnglish.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.grey,
                                  ),
                                  title: Text(
                                    desEnglish[index].toString(),
                                    style: getBodyStyle(color: AppColors.black),
                                  ),
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
              print(desArabic);

              print(desEnglish);

              if (desArabic.isNotEmpty && desEnglish.isNotEmpty) {
                push(
                    context,
                    HowToUse(
                      name: widget.name,
                      price: widget.price,
                      image1: widget.image1,
                      image2: widget.image2,
                      needed: widget.needed,
                      desArabic: desArabic,
                      desEnglish: desEnglish,
                      cat: widget.cat,
                    ));
              } else {
                showErrorDialog(context,
                    'Make sure you added both of the descriptions items');
              }
              // push(context, const HowToUse());
            },
            style: getTitleStyle(color: AppColors.white),
            text: S.of(context).next,
            bgcolor: AppColors.primary),
      ),
    );
  }
}
