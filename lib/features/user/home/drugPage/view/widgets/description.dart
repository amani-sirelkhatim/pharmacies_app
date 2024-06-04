import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Description extends StatefulWidget {
  const Description({super.key, required this.productid});
  final String productid;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Customer')
            .where('id', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }
          var userdata = snapshot.data!.docs;
          return userdata[0]['language'] != null
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .where('drugid', isEqualTo: widget.productid)
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
                    List Description = [];
                    if (userdata[0]['language'] == 'Arabic') {
                      Description = drug['descriptionArabic'];
                    } else {
                      Description = drug['descriptionEnglish'];
                    }
                    // List ArabicdescriptionList = drug['descriptionArabic'];
                    // List EnglishdescriptionList = drug['descriptionEnglish'];
                    return DrugsData.isNotEmpty &&
                            drug != null &&
                            Description.isNotEmpty
                        ? ListView.builder(
                            itemCount: Description.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.grey,
                                ),
                                title: Text(Description[index],
                                    style: getBodyStyle()),
                              );
                            })
                        : SizedBox();
                  })
              : SizedBox();
        });
  }
}
