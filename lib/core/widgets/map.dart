import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class MapTest extends StatefulWidget {
  const MapTest({super.key, required this.id, required this.type});
  final String id;
  final int type;
  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(S.of(context).setaddress,
              style: getTitleStyle(color: AppColors.primary)),
        ),
        body: OpenStreetMapSearchAndPick(
          locationPinIconColor: AppColors.primary,
          buttonTextStyle: getBodyStyle(color: AppColors.white),
          buttonColor: AppColors.primary,
          buttonText: S.of(context).currentlocation,
          onPicked: (pickedData) async {
            if (widget.type == 1) {
              await FirebaseFirestore.instance
                  .collection('Customer')
                  .doc(widget.id)
                  .set({
                'address': pickedData.addressName,
              }, SetOptions(merge: true));
            } else {
              FirebaseFirestore.instance
                  .collection('Pharmacy')
                  .doc(widget.id)
                  .set({
                'address': pickedData.addressName,
              }, SetOptions(merge: true));
            }

            // print(pickedData.latLong.latitude);
            // print(pickedData.latLong.longitude);
            // print(pickedData.address);
            // print(pickedData.addressName);
          },
        ));
  }
}
