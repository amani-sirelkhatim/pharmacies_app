import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/features/user/favorites/favorite.dart';
import 'package:pharmacies_app/features/user/home/home.dart';
import 'package:pharmacies_app/features/user/orders/orders.dart';
import 'package:pharmacies_app/features/user/profile/profile.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PatientNav extends StatefulWidget {
  const PatientNav({super.key});

  @override
  State<PatientNav> createState() => _PatientNavState();
}

class _PatientNavState extends State<PatientNav> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 5;

  final List<Widget> bottomBarPages = [
    const PatientHome(),
    const Favorite(),
    const Orders(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: AppColors.primary,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,

              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: AppColors.primary,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: AppColors.white,
                  ),
                  itemLabel: S.of(context).home,
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite,
                    color: AppColors.primary,
                  ),
                  activeItem: Icon(
                    Icons.favorite,
                    color: AppColors.white,
                  ),
                  itemLabel: S.of(context).favorite,
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shopping_cart_rounded,
                    color: AppColors.primary,
                  ),
                  activeItem: Icon(
                    Icons.shopping_cart_rounded,
                    color: AppColors.white,
                  ),
                  itemLabel: S.of(context).orders,
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: AppColors.primary,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: AppColors.white,
                  ),
                  itemLabel: S.of(context).profile,
                ),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}
