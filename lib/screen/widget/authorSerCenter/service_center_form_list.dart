import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/screen/widget/authorSerCenter/address_selection_form.dart';

import '../../../config/color.dart';

class ServiceCenterForm extends StatelessWidget {
  const ServiceCenterForm({super.key});
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
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  AddressSelectionForm(),
                  const SizedBox(height: 15,),
                  
                ],
              ),
               // Replace with your actual content
              
            ),
          ],
        ),
      //  Center(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      //     color: AppColors.backgroudWhite,
      //     child: const FittedBox(
      //       fit: BoxFit.scaleDown,
      //       child: Text(
      //         'Tìm kiếm',
      //         style: TextStyle(
      //           fontSize: 20.0,
      //           color: AppColors.titleColor,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      ],
    );
  }
}
