import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';

class PickerDate extends StatelessWidget {
   PickerDate({required this.lable,
      required this. controller,
      required this.checkOpen,
      required  this.selectableDayPredicate,
      required  this.day,
        super.key,}
      );
    String lable;
       TextEditingController controller;
       bool checkOpen;
       bool Function(DateTime)? selectableDayPredicate;
       DateTime? day;
      

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(

             enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            label: Text(lable),
          ),
          onTap: () async {
            if (checkOpen) {
              day = await showDatePicker(
                context: context,
                
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
                selectableDayPredicate: selectableDayPredicate,
              );
              controller.text = day != null ? Utils().convertDate(day!) : "";
            
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng chọn từ ngày')));
            
            }
          },
        ),
      ),
    );
  }
  
}