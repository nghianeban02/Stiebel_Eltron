import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/model/list_active_model.dart';
import 'package:stiebel_etron_warranty/screen/widget/warranty_product_info.dart';

import '../../../config/color.dart';

class BorderListActivation extends StatelessWidget {
   BorderListActivation({required this.listDataActive,super.key});
  ListDataActive listDataActive =ListDataActive();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      border: Border.all( 
          color: AppColors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child:  Padding(
        padding: EdgeInsets.all(1.0),
        child: WarrantyProductInfo(activeModel: listDataActive,), // Replace with your actual content
      ),
    );
    
  }
}