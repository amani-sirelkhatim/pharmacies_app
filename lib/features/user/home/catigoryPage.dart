import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/drugPage/drugPage.dart';
import 'package:pharmacies_app/features/user/home/widgets/drugCard.dart';

class CatPage extends StatefulWidget {
  const CatPage({super.key, required this.Cat, required this.title});
  final String Cat;
  final String title;
  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: 10, // Set the number of items you want in the grid
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  push(context, DrugPage());
                },
                child: DrugCard());
          },
        ),
      ),
    );
  }
}
