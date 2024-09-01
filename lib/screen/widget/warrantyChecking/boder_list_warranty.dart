import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/model/list_active_model.dart';
import 'package:stiebel_etron_warranty/screen/widget/warranty_product_info.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

import '../../../config/color.dart';

class BorderListWarranty extends StatelessWidget {
   ListDataActive listDataActive;
   BorderListWarranty({super.key ,required this.listDataActive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 25,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 2.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              child:  Padding(
                padding: EdgeInsets.all(10.0),
                child:WarrantyProductInfo(activeModel:listDataActive), // Replace with your actual content
              ),
            ),
          ],
        ),
       Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          color: AppColors.backgroudWhite,
          child:  FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              LocaleKeys.searchWarranty.tr,
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.titleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      ],
    );
  }
}
