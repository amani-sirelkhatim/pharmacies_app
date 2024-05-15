import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/tabbar.dart';

class AdminDrugPage extends StatefulWidget {
  const AdminDrugPage({super.key, required this.name, required this.id});
  final String name;
  final String id;

  @override
  State<AdminDrugPage> createState() => _AdminDrugPageState();
}

class _AdminDrugPageState extends State<AdminDrugPage> {
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
      ),
      body: Column(
        children: [
          AdminTabBar()],
      ),
    );
  }
}
