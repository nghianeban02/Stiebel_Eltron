import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

class ListProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return  SingleChildScrollView(
          child: Column(
            
            children: [
              // Máy nước nóng section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/list1.jpg', // Thay bằng link ảnh thực tế hoặc sử dụng AssetImage nếu là ảnh local
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(width: 16),
                     Expanded(
                      child: textProduct(LocaleKeys.waterHeater.tr,
                      LocaleKeys.waterHeater1.tr,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Máy lọc nước section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/list2.jpg', // Thay bằng link ảnh thực tế hoặc sử dụng AssetImage nếu là ảnh local
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(width: 16),
                     Expanded(
                      child: textProduct(
                        LocaleKeys.waterPurifier.tr,
                        LocaleKeys.waterPurifier1.tr,
                      ),
                    ),
                  ],
                ),
              ),
            const Divider(),
             Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/list3.jpg', // Thay bằng link ảnh thực tế hoặc sử dụng AssetImage nếu là ảnh local
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(width: 16),
                     Expanded(
                      child: textProduct(
                        LocaleKeys.heatPump.tr,
                        LocaleKeys.heatPump1.tr,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ) 
    );
  }
}
Widget textProduct(String title, String content) {
  return  Column(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 18,
         fontWeight: FontWeight.bold,
         color: AppColors.primary,
         ),
         textAlign: TextAlign.left,
      ),
      const SizedBox(height:8),  
      Text(
        content,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      )
    ],
  );
   
} 