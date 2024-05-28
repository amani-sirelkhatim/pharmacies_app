import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class DrugHow extends StatefulWidget {
  const DrugHow({super.key, required this.drugid});
  final String drugid;
  @override
  State<DrugHow> createState() => _DrugHowState();
}

class _DrugHowState extends State<DrugHow> {
  final TextEditingController _arabicitemController = TextEditingController();
  final TextEditingController _englishitemController = TextEditingController();
  final TextEditingController _newitemController = TextEditingController();
  bool isLoading = false;
  Future<void> updateDrugField(int type, int index, String newValue) async {
    String field = type == 1 ? 'howtouseArabic' : 'howtouseEnglish';
    var drugDocRef =
        FirebaseFirestore.instance.collection('Products').doc(widget.drugid);
    DocumentSnapshot doc = await drugDocRef.get();
    List<dynamic> list = doc[field];

    if (index >= 0 && index < list.length) {
      list[index] = newValue;
      await drugDocRef.update({field: list});
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteDrugField(int type, int index) async {
    String field = type == 1 ? 'howtouseArabic' : 'howtouseEnglish';
    var drugDocRef =
        FirebaseFirestore.instance.collection('Products').doc(widget.drugid);
    DocumentSnapshot doc = await drugDocRef.get();
    List<dynamic> list = doc[field];

    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      await drugDocRef.update({field: list});
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addDrugField(int type, String newValue) async {
    String field = type == 1 ? 'howtouseArabic' : 'howtouseEnglish';
    var drugDocRef =
        FirebaseFirestore.instance.collection('Products').doc(widget.drugid);
    DocumentSnapshot doc = await drugDocRef.get();
    List<dynamic> list = doc[field];

    list.add(newValue);
    await drugDocRef.update({field: list});
    _newitemController.clear();
    setState(() {
      isLoading = false;
    });
  }

  void showAddDialog(int type) {
    _newitemController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.white,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: _newitemController,
                    style: TextStyle(color: AppColors.black),
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
                        Icons.medical_information_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).pharmacyname;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CustomButton(
                    text: S.of(context).save,
                    bgcolor: AppColors.primary,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String newValue = _newitemController.text.trim();
                      if (newValue.isNotEmpty) {
                        Navigator.of(context).pop();
                        await addDrugField(type, newValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  addDialog(int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _newitemController,
                        style: TextStyle(color: AppColors.black),

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
                            Icons.medical_information_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        // controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).pharmacyname;
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      CustomButton(
                          text: S.of(context).save,
                          bgcolor: AppColors.primary,
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            String newValue = _newitemController.text.trim();

                            if (newValue.isNotEmpty) {
                              Navigator.of(context).pop();
                              await addDrugField(type, newValue);
                            }
                          })
                    ],
                  ),
                )
              ]);
        });
  }

  updateDialog(int type, String item, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: type == 1
                            ? _arabicitemController
                            : _englishitemController,
                        style: TextStyle(color: AppColors.black),

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
                            Icons.medical_information_outlined,
                            color: AppColors.primary,
                          ),
                        ),
                        // controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).pharmacyname;
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              text: S.of(context).save,
                              bgcolor: AppColors.primary,
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Navigator.of(context).pop();
                                String newValue = type == 1
                                    ? _arabicitemController.text.trim()
                                    : _englishitemController.text.trim();
                                if (newValue.isNotEmpty) {
                                  await updateDrugField(type, index, newValue);
                                }
                              }),
                          CustomButton(
                              text: S.of(context).delete,
                              bgcolor: Colors.red,
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Navigator.of(context).pop();
                                deleteDrugField(type, index);
                              }),
                        ],
                      )
                    ],
                  ),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ?const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('drugid', isEqualTo: widget.drugid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }

                  var DrugsData = snapshot.data!.docs;
                  var drug = DrugsData[0];
                  List ArabicHowList = drug['howtouseArabic'];
                  List EnglishHowList = drug['howtouseEnglish'];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding:const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(.5))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    S.of(context).usearabic + " :",
                                    style:
                                        getTitleStyle(color: AppColors.primary),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        //  addDrugField(1, newValue)
                                        addDialog(1);
                                      },
                                      icon:const Icon(Icons.add))
                                ],
                              ),
                              DrugsData.isNotEmpty &&
                                      drug != null &&
                                      ArabicHowList.isNotEmpty &&
                                      EnglishHowList.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: ArabicHowList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          title: Text(
                                            ArabicHowList[index].toString(),
                                            style: getBodyStyle(
                                                color: AppColors.black),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _arabicitemController.text =
                                                      ArabicHowList[index]
                                                          .toString();
                                                });
                                                updateDialog(
                                                    1,
                                                    _arabicitemController.text,
                                                    index);
                                              },
                                              icon:const Icon(
                                                Icons.edit,
                                                size: 15,
                                              )),
                                        );
                                      })
                                  : const SizedBox(),
                              const Divider(),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).useenglish + " :",
                                    style:
                                        getTitleStyle(color: AppColors.primary),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        //  addDrugField(1, newValue)
                                        addDialog(2);
                                      },
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                              DrugsData.isNotEmpty &&
                                      drug != null &&
                                      ArabicHowList.isNotEmpty &&
                                      EnglishHowList.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: EnglishHowList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          title: Text(
                                            EnglishHowList[index].toString(),
                                            style: getBodyStyle(
                                                color: AppColors.black),
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _englishitemController.text =
                                                      EnglishHowList[index]
                                                          .toString();
                                                });
                                                updateDialog(
                                                    2,
                                                    _englishitemController.text,
                                                    index);
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                size: 15,
                                              )),
                                        );
                                      })
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
