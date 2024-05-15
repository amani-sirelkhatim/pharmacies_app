import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/widgets/DrugDeacription.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/widgets/DrugHow.dart';
import 'package:pharmacies_app/features/pharmacy/AdminDrugPage/widgets/DrugMain.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class AdminTabBar extends StatefulWidget {
  const AdminTabBar({super.key});

  @override
  State<AdminTabBar> createState() => _AdminTabBarState();
}

class _AdminTabBarState extends State<AdminTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: AppColors.primary,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: S.of(context).description,
                  ),
                  Tab(
                    text: S.of(context).description,
                  ),
                  Tab(
                    text: S.of(context).use,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    DrugMain(),
                    DrugDescription(),
                    DrugHow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
