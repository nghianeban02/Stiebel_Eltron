import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:stiebel_etron_warranty/screen/widget/pickerDate.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

class TabBarPhone extends StatelessWidget {
   TabBarPhone({super.key});
  TextEditingController phoneController=TextEditingController();
  TextEditingController fromDateController=TextEditingController();
  TextEditingController toDateController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: PickerDate(lable:LocaleKeys.fromDay.tr,controller:fromDateController,checkOpen:true, selectableDayPredicate: (dateTime ) { return dateTime.isBefore(DateTime.now()); },day: DateTime.now()),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PickerDate(lable:LocaleKeys.toDay.tr,controller:toDateController,checkOpen:true, selectableDayPredicate: (dateTime ) { return dateTime.isBefore(DateTime.now()); },day: DateTime.now()),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildPhoneField(context,LocaleKeys.phoneNumber.tr,phoneController),
                  ),
                  const SizedBox(width: 10),
                  _buildSearchButton(context),
                ],
              ),
            ],
          ),
    );
  }

  // Widget _buildDateField(BuildContext context, String label,) {
  //   return SizedBox(
  //     height: 50,
  //     child: TextFormField(
  //       decoration: InputDecoration(
  //         labelText: label,
  //         labelStyle: const TextStyle(color: AppColors.text), // Label color when not focused
  //         floatingLabelStyle: const TextStyle(color: AppColors.primary), // Label color when focused
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: AppColors.primary),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: const BorderSide(color: AppColors.primary),
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPhoneField(BuildContext context, String label,TextEditingController controller) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.text), // Label color when not focused
          floatingLabelStyle: const TextStyle(color: AppColors.primary), // Label color when focused
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextButton(
        onPressed: () {
          BlocProvider.of<ActivateCubit>(context).getListActivate(phone:phoneController.text,fromDate: Utils().convertDateSytem(fromDateController.text),toDate:Utils().convertDateSytem(toDateController.text));
          // Handle search functionality );
          // Handle search functionality
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        child: Image.asset(
          'assets/icon/find.png', // Đường dẫn tới hình ảnh
          color: AppColors.primary, // Màu của hình ảnh
        ),
      ),
    );
  }

}
