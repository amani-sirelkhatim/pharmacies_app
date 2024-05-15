import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/pharmacy/add%20drug/view/addItem.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/AdminDrugPage.dart';
import 'package:pharmacies_app/features/pharmacy/home/widgets/itemcard.dart';
import 'package:pharmacies_app/features/user/home/drugPage/drugPage.dart';

class ItemsGrid extends StatefulWidget {
  const ItemsGrid({super.key, required this.Cat, required this.title});
  final String Cat;
  final String title;
  @override
  State<ItemsGrid> createState() => _ItemsGridState();
}

class _ItemsGridState extends State<ItemsGrid> {
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
              .where('pharmacyid', isEqualTo: user!.uid)
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                        return drug != null && drug.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  push(
                                      context,
                                      AdminDrugPage(
                                        id: drug['drugid'],
                                        name: drug['name'],
                                      ));
                                },
                                child: ItemCard(
                                  image: drug['frontimage'] ?? '',
                                  name: drug['name'] ?? '',
                                ))
                            : SizedBox();
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'There are no products yet',
                      style: getTitleStyle(color: AppColors.primary),
                    ),
                  );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: 50,
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  push(
                      context,
                      AddItem(
                        Cat: widget.Cat,
                      ));
                },
                backgroundColor: AppColors.primary,
                // mini: true,
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
