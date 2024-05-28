import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Use extends StatefulWidget {
  const Use({super.key, required this.productid});
  final String productid;

  @override
  State<Use> createState() => _UseState();
}

class _UseState extends State<Use> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          if (S.of(context).language == 'ar') {
            Description = drug['howtouseArabic'];
          } else {
            Description = drug['howtouseEnglish'];
          }
          return DrugsData.isNotEmpty && drug != null && Description.isNotEmpty
              ? ListView.builder(
                  itemCount: Description.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.grey,
                      ),
                      title: Text(Description[index],style: getBodyStyle(),),
                    );
                  })
              : SizedBox();
        });
  }
}
