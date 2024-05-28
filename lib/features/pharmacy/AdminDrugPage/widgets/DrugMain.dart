import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class DrugMain extends StatefulWidget {
  const DrugMain({super.key, required this.drugid});
  final String drugid;

  @override
  State<DrugMain> createState() => _DrugMainState();
}

class _DrugMainState extends State<DrugMain> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late bool needed;
  void toggleNeeded() {
    setState(() {
      needed = !needed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
              return DrugsData.isNotEmpty && drug != null
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.grey.withOpacity(.5))),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(S.of(context).name + " :",
                                      style: getTitleStyle(
                                          color: AppColors.primary)),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    drug['name'],
                                    style: getBodyStyle(),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          showeditdialog(1);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppColors.primary,
                                          size: 15,
                                        )))
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(S.of(context).price + " :",
                                      style: getTitleStyle(
                                          color: AppColors.primary)),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    drug['price'].toString(),
                                    style: getBodyStyle(),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          showeditdialog(2);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppColors.primary,
                                          size: 15,
                                        )))
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(S.of(context).Perscription + " :",
                                      style: getTitleStyle(
                                          color: AppColors.primary)),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    drug['perscription'] == true
                                        ? S.of(context).yes
                                        : S.of(context).no,
                                    style: getBodyStyle(),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () {
                                          showeditdialog(3);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: AppColors.primary,
                                          size: 15,
                                        )))
                              ],
                            ),
                          ]),
                        )
                      ],
                    )
                  : SizedBox();
            }),
      ),
    );
  }

  showeditdialog(int type) {
    if (type == 3) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(widget.drugid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ));
                      }

                      var DrugData = snapshot.data;

                      int newneeded = DrugData!['perscription'] == true ? 1 : 2;

                      return DrugData != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(S.of(context).Perscription,
                                    style: getTitleStyle(
                                        color: AppColors.primary)),
                                ListTile(
                                  title: Text(S.of(context).yes,
                                      style: getBodyStyle(fontSize: 15)),
                                  leading: Radio<int>(
                                    value: 1,
                                    groupValue: newneeded,
                                    activeColor: AppColors.primary,
                                    fillColor: MaterialStateProperty.all(
                                        AppColors.primary),
                                    splashRadius: 20,
                                    onChanged: (int? value) {
                                      setState(() {
                                        newneeded = value!;
                                        Navigator.of(context).pop();
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Products')
                                              .doc(widget.drugid)
                                              .set({
                                            'perscription': true,
                                          }, SetOptions(merge: true));
                                          print('done');
                                        } catch (e) {
                                          showErrorDialog(
                                              context, e.toString());
                                        }
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    S.of(context).no,
                                    style: getBodyStyle(fontSize: 15),
                                  ),
                                  leading: Radio<int>(
                                    value: 2,
                                    groupValue: newneeded,
                                    activeColor: AppColors
                                        .primary, // Change the active radio button color here
                                    fillColor: MaterialStateProperty.all(AppColors
                                        .primary), // Change the fill color when selected
                                    splashRadius:
                                        25, // Change the splash radius when clicked
                                    onChanged: (int? value) {
                                      setState(() {
                                        newneeded = value!;
                                        Navigator.of(context).pop();
                                        try {
                                          FirebaseFirestore.instance
                                              .collection('Products')
                                              .doc(widget.drugid)
                                              .set({
                                            'perscription': false,
                                          }, SetOptions(merge: true));
                                        } catch (e) {
                                          showErrorDialog(
                                              context, e.toString());
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox();
                    })
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
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

                        var DrugData = snapshot.data!.docs;
                        var drug = DrugData[0];
                        if (DrugData.isNotEmpty && drug != null) {
                          _nameController.text = drug['name'] != null
                              ? drug['name'].toString()
                              : '';
                          _priceController.text = drug['price'] != null
                              ? drug['price'].toString()
                              : '';
                          needed = drug['perscription'] == true ? true : false;
                        }
                        return drug != null
                            ? Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    if (type == 1)
                                      TextFormField(
                                        controller: _nameController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label:
                                              Text(S.of(context).pharmacyname),
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
                                    if (type == 2)
                                      TextFormField(
                                        controller: _priceController,
                                        style:
                                            TextStyle(color: AppColors.black),

                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          focusColor: AppColors.primary,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          label: Text(S.of(context).price),
                                          labelStyle: getBodyStyle(),
                                          prefixIcon: Icon(
                                            Icons.monetization_on_outlined,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        // controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return S.of(context).email;
                                          }
                                          return null;
                                        },
                                      ),
                                    const Gap(20),
                                    CustomButton(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            update(
                                              type,
                                              _nameController.text,
                                              _priceController.text,
                                            );
                                          }
                                        },
                                        text: S.of(context).save,
                                        bgcolor: AppColors.primary)
                                  ],
                                ),
                              )
                            : const SizedBox();
                      }),
                ),
              ],
            );
          });
    }
  }

  update(
    int type,
    String name,
    String price,
  ) {
    if (type == 1) {
      try {
        FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.drugid)
            .set({
          'name': name,
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok: S.of(context).ok,
            alert:S.of(context).updated,
            Subtiltle: '', onTap: () {
          Navigator.pop(context);
        });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    } else if (type == 2) {
      try {
        FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.drugid)
            .set({
          'price': price,
        }, SetOptions(merge: true));
        showSentAlertDialog(context,
            title: 'done',
            ok: S.of(context).ok,
            alert: S.of(context).updated,
            Subtiltle: '', onTap: () {
          Navigator.pop(context);
        });
      } catch (e) {
        showErrorDialog(context, e.toString());
      }
    }
  }
}
