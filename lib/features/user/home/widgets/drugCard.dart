import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacies_app/core/utils/colors.dart';

import 'package:pharmacies_app/core/utils/styles.dart';

class DrugCard extends StatefulWidget {
  const DrugCard({
    super.key,
    required this.image,
    required this.name,
    required this.productid,
    required this.pharmacyname,
  });
  final String image;
  final String name;
  final String productid;
  final String pharmacyname;

  @override
  State<DrugCard> createState() => _DrugCardState();
}

class _DrugCardState extends State<DrugCard> {
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
    isdrugSaved(widget.productid);
  }

  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  Future<void> isdrugSaved(String drugid) async {
    // Check if the job is saved in the 'saved' collection
    final snapshot = await FirebaseFirestore.instance
        .collection('Favorite')
        .doc(user!.uid)
        .collection('Favorite')
        .where('productid', isEqualTo: drugid)
        .get();
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        issaved = true;
      });
    }
  }

  Future<void> deleteDocument({required String drugid}) async {
    try {
      // Perform a query to find the document based on fields
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Favorite')
          .doc(user!.uid) // Replace with your user ID
          .collection('Favorite')
          .where('productid', isEqualTo: drugid)
          .get();

      // Delete the found document(s)
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> save(
      {required String image,
      required String drugid,
      required String pharmacyname,
      required String productname}) async {
    try {
      final CollectionReference collection = FirebaseFirestore.instance
          .collection('Favorite')
          .doc(user!.uid)
          .collection('Favorite');

      // Add the skill to Firestore with an automatically generated document ID
      await collection.add({
        'productid': drugid,
        'productname': productname,
        'image': image,
        'pharmacyname': pharmacyname,

        // Add more fields based on your Skill model
      });
    } catch (e) {
      print(e);
    }

    // Optionally, you can clear the text field after adding the skill
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.5),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Stack(children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    child: Image.network(
                      widget.image,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )),
                IconButton(
                    onPressed: () {
                      if (issaved) {
                        deleteDocument(drugid: widget.productid);
                      } else {
                        save(
                            productname: widget.name,
                            image: widget.image,
                            drugid: widget.productid,
                            pharmacyname: widget.pharmacyname);
                      }
                      toggleSaved();
                    },
                    icon: Icon(
                      issaved
                          ? Icons.favorite
                          : Icons.favorite_outline_outlined,
                      color: Colors.red,
                    ))
              ]),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  widget.name,
                  style: getBodyStyle(color: AppColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
