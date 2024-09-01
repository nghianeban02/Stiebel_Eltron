import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../config/components/appDefaults.dart';
import '../config/color.dart';
import '../config/icon.dart';
import '../config/components/appBarItemBotton.dart';


class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onNavTap,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: AppDefaults.margin,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomAppBarItem(
            name: LocaleKeys.home.tr,
            iconLocation: AppIcon.home,
            isActive: currentIndex == 0,
            onTap: () => onNavTap(0),
          ),
          BottomAppBarItem(
            name: LocaleKeys.activate.tr,
            iconLocation: AppIcon.warranty,
            isActive: currentIndex == 1,
            onTap: () => onNavTap(1),
          ),
          BottomAppBarItem(
            name: LocaleKeys.search.tr,
            iconLocation: AppIcon.search,
            isActive: currentIndex == 2,
            onTap: () => onNavTap(2),
          ),
          BottomAppBarItem(
            name: LocaleKeys.statistic.tr,
            iconLocation: AppIcon.chart,
            isActive: currentIndex == 3,
            onTap: () => onNavTap(3),
          ),
        ],
      ),
    );
  }
}
