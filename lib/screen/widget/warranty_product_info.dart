import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:stiebel_etron_warranty/model/list_active_model.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';

class WarrantyProductInfo extends StatelessWidget {
   ListDataActive? activeModel;
   WarrantyProductInfo({super.key , this.activeModel});

  @override
  Widget build(BuildContext context) {
    
    return   Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
              child: Text(
             '${activeModel?.categoryName??''} | ${activeModel?.modelName??''}'
               ,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                 Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.status.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(activeModel!.getStatus),
                    ),
                  ],
                ),

                Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.modelName.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(activeModel?.modelName ?? ''),
                    ),
                  ],
                ),
                 Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.serial.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(activeModel?.serial??''),
                    ),
                  ],
                ),
                 Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.customer.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(activeModel?.customerNameActiveData??''),
                    ),
                  ],
                ),
            activeModel?.dateExportStock!=null?     Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.dayBuy.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(Utils().convertStringDate(activeModel?.dateExportStock??DateTime.now().toString())),
                    ),
                  ],
                ):SizedBox(),
                 Row(
                  children: [
                     Expanded(
                      flex: 4,
                      child: Text(
                        LocaleKeys.activateDate.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(Utils().convertStringDate(activeModel?.createDate??DateTime.now().toString())),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 20),
             Center(
              child: Text(
                LocaleKeys.warranty2Years.tr,
                style: const TextStyle(color: AppColors.textRed),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
    );
  }
}
