import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/widgets/AdminSlider.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/widgets/AdminTabBar.dart';
import 'package:pharmacies_app/features/pharmacy/pharmacyNav.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class AdminDrugPage extends StatefulWidget {
  const AdminDrugPage({super.key, required this.name, required this.id});
  final String name;
  final String id;

  @override
  State<AdminDrugPage> createState() => _AdminDrugPageState();
}

class _AdminDrugPageState extends State<AdminDrugPage> {
  Future<void> deleteDocument({required String drugid}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('drugid', isEqualTo: drugid)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
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
          widget.name,
          style: getTitleStyle(color: AppColors.primary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(S.of(context).deleteproduct,
                                    style:
                                        getBodyStyle(color: AppColors.primary)),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: CustomButton(
                                            text: S.of(context).yes,
                                            bgcolor: Colors.red,
                                            onTap: () {
                                              deleteDocument(drugid: widget.id);
                                              pushWithReplacment(
                                                  context, const PharmacyNav());
                                            })),
                                const    Gap(20),
                                    Expanded(
                                        child: CustomButton(
                                            text: S.of(context).no,
                                            bgcolor: AppColors.primary,
                                            onTap: () {
                                              Navigator.pop(context);
                                            }))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Column(
        children: [
          AdminSlider(drugid: widget.id),
          AdminTabBar(
            drugid: widget.id,
          )
        ],
      ),
    );
  }
}
