import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/features/user/favorites/widgets/favoriteCard.dart';
import 'package:pharmacies_app/features/user/home/drugPage/drugPage.dart';
import 'package:pharmacies_app/features/user/home/widgets/drugCard.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              color: AppColors.primary,
              child: Text(
                S.of(context).favorite,
                style: getTitleStyle(color: AppColors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: 5, // Set the number of items you want in the grid
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          push(context, DrugPage());
                        },
                        child: FavoriteCard());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
