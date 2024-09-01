import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_text.dart';

import '../../model/list_active_model.dart';

class ListFormActivate extends StatelessWidget {
  ListFormActivate({super.key, required this.titles, required this.DOITAC});
  final List<ListDataActive> titles;
  final bool DOITAC;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return itemListActivate(index, titles[index], index % 2 == 0 ? AppColors.primary : AppColors.primary.withOpacity(0.1));
        });
  }

  Widget itemListActivate(int index, ListDataActive listDataActive, Color color) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: color),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText().textSize16(text: listDataActive.createDate ?? '', color: AppColors.black, fontWeight: FontWeight.w600),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText().textSize14(text: "Sản phẩm", color: AppColors.primary),
                  CustomText().textSize14(text: "Model", color: AppColors.primary),
                  CustomText().textSize14(text: "Mã kích hoạt", color: AppColors.primary),
                  CustomText().textSize14(text: "Số seri", color: AppColors.primary),
                  if (DOITAC) ...{
                    CustomText().textSize14(text: "Kích hoạt", color: AppColors.primary),
                    CustomText().textSize14(text: "Tích điểm", color: AppColors.primary),
                  }
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText().textSize16(text: listDataActive.categoryName),
                  CustomText().textSize16(text: listDataActive.modelName),
                  CustomText().textSize16(text: listDataActive.id.toString()),
                  CustomText().textSize16(text: listDataActive.serial),
                  if (DOITAC) ...{
                    CustomText().textSize16(text: Utils.moneyFormat(double.parse(listDataActive.price.toString()))),
                    CustomText().textSize16(text: listDataActive.status.toString()),
                  }
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
