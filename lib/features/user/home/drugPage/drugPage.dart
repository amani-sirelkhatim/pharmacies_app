import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/home/drugPage/widgets/imageSlider.dart';
import 'package:pharmacies_app/features/user/home/drugPage/widgets/tabBar.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class DrugPage extends StatefulWidget {
  const DrugPage({super.key});

  @override
  State<DrugPage> createState() => _DrugPageState();
}

class _DrugPageState extends State<DrugPage> {
  int price = 100;

  int amount = 1;

  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
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
        actions: [
          IconButton(
              onPressed: () {
                toggleSaved();
              },
              icon: Icon(
                issaved ? Icons.favorite : Icons.favorite_outline_outlined,
                color: Colors.red,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ImageSlider(),
            Container(
              width: 120,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        amount = amount + 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey,
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        size: 30,
                        Icons.add,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Text(amount.toString()),
                  GestureDetector(
                    onTap: () {
                      if (amount > 1) {
                        setState(() {
                          amount = amount - 1;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey,
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        size: 30,
                        Icons.remove,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            TabButtunBar(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            padding: EdgeInsets.all(15),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.primary),
            child: Row(children: [
              Text(
                S.of(context).cart,
                style: getTitleStyle(color: AppColors.white),
              ),
              Spacer(),
              Text(
                '${price * amount}',
                style: getTitleStyle(color: AppColors.white),
              )
            ])),
      ),
    );
  }
}
