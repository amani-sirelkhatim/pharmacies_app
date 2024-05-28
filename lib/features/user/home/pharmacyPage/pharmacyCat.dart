import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/drugPage.dart';
import 'package:pharmacies_app/features/user/home/widgets/drugCard.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class pharmacyCatPage extends StatefulWidget {
  const pharmacyCatPage(
      {super.key,
      required this.Cat,
      required this.title,
      required this.pharmacyid});
  final String Cat;
  final String title;
  final String pharmacyid;
  @override
  State<pharmacyCatPage> createState() => _pharmacyCatPageState();
}

class _pharmacyCatPageState extends State<pharmacyCatPage> {
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
          widget.title,
          style: getTitleStyle(color: AppColors.primary),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('cattegory', isEqualTo: widget.Cat)
              .where('pharmacyid', isEqualTo: widget.pharmacyid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }

            var DrusData = snapshot.data!.docs;
            return DrusData.isNotEmpty && DrusData != null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemCount: DrusData
                          .length, // Set the number of items you want in the grid
                      itemBuilder: (BuildContext context, int index) {
                        var drug = index < DrusData.length
                            ? DrusData[index].data() as Map<String, dynamic>
                            : null;
                        return drug != null
                            ? GestureDetector(
                                onTap: () {
                                  push(
                                      context,
                                      DrugPage(
                                        pharmacyname: drug['pharmacyname'],
                                        productid: drug['drugid'],
                                      ));
                                },
                                child: DrugCard(
                                   pharmacyname: drug['pharmacyname'],
                                  productid: drug['drugid'],
                                  image: drug['frontimage'],
                                  name: drug['name'],
                                ))
                            : SizedBox();
                      },
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 20),
                      child: Text(
                        S.of(context).noproducts,
                        style: getTitleStyle(color: AppColors.primary),
                      ),
                    ),
                  );
          }),
    );
  }
}
