import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/screen/widget/activationStatistic/list_statistic.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'boder_list_activation.dart';

class TabBarSerial extends StatelessWidget {
  TabBarSerial({super.key});
  TextEditingController serialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSerialField(
                    context, LocaleKeys.serial.tr, serialController),
              ),
              const SizedBox(width: 10),
              _buildSearchButton(context),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSerialField(
      BuildContext context, String label, TextEditingController controller) {
    return SizedBox(
      height: 50, // Set the height to 40px
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.serialCannotBeEmpty.tr;
          }
          if (value.length < 16 || value.length > 20) {
            return LocaleKeys.serial16To20.tr;
          }
          return null;
        },
        onChanged: (value) {
          String newValue = value.replaceAll('-', '');
          if (newValue.length > 4) {
            newValue = newValue.replaceAllMapped(
                RegExp(r'.{4}'), (match) => '${match.group(0)}-');
            if (newValue.endsWith('-')) {
              newValue = newValue.substring(0, newValue.length - 1);
            }
          }
          serialController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(offset: newValue.length),
          );
          serialController.text = newValue;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.text),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          floatingLabelStyle: const TextStyle(color: AppColors.primary),
          prefixIcon: _buildQRCodeButton(),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: 10), // Adjust content padding
        ),
      ),
    );
  }

  Widget _buildQRCodeButton() {
    return IconButton(
      iconSize: 24,
      icon: const Icon(Icons.qr_code, color: AppColors.primary),
      onPressed: () {
        // Handle QR code functionality
      },
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextButton(
        onPressed: () {
          // Handle search functionality
          BlocProvider.of<ActivateCubit>(context)
              .getListActivate(serial: serialController.text);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
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
