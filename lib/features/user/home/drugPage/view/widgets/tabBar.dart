import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/widgets/description.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/widgets/use.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class TabButtunBar extends StatefulWidget {
  const TabButtunBar({super.key, required this.productid});
  final String productid;
  @override
  State<TabButtunBar> createState() => _TabButtonBarState();
}

class _TabButtonBarState extends State<TabButtunBar> {
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
                    text: S.of(context).use,
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Description(
                      productid: widget.productid,
                    ),
                    Use(productid: widget.productid),
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
