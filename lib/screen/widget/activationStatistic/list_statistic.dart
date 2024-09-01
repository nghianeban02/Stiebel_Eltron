import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../../config/color.dart';

class ListStatistic extends StatelessWidget {
  const ListStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // backgroundColor: AppColors.backgroudWhite,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(
              "${LocaleKeys.totalActivate.tr}:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatisticButton("2",LocaleKeys.activateTotal.tr, AppColors.black),
                const SizedBox(width: 5),
                _buildStatisticButton("1",LocaleKeys.activateSuccess.tr, AppColors.green),
                const SizedBox(width: 5),
                _buildStatisticButton("1",LocaleKeys.activateFail.tr, AppColors.error),
                const SizedBox(width: 5),
                _buildStatisticButton("0",LocaleKeys.activatePending.tr, AppColors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticButton(String count, String label, Color borderColor) {
    return SizedBox(
      width: 80,
      height: 46,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        ),
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: borderColor),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: borderColor),
            ),
          ],
        ),
      ),
    );
  }
}
