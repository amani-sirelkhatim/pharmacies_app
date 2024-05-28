import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/styles.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard(
      {super.key, required this.productname, required this.productid});
  final String productname;
  final String productid;

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
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

  bool issaved = true;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.5),
        ),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  child: Image.asset('assets/images/antibiotics.jpg')),
              IconButton(
                  onPressed: () {
                    deleteDocument(drugid: widget.productid);
                  },
                  icon: Icon(
                    issaved ? Icons.favorite : Icons.favorite_outline_outlined,
                    color: Colors.red,
                  ))
            ]),
            Text(
              widget.productname,
              style: getBodyStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
