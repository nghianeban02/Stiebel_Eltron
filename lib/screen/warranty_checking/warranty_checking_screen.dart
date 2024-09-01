import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/screen/warranty_checking/list_checking_screen.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/screen/widget/warrantyChecking/check_button.dart';
import 'package:stiebel_etron_warranty/screen/widget/warrantyChecking/check_form_phone.dart';
import 'package:stiebel_etron_warranty/screen/widget/warrantyChecking/check_form_serial.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/service/validator.dart';
import '../../config/color.dart';
import '../../config/icon.dart';

class WarrantyCheckScreen extends StatefulWidget {
  const WarrantyCheckScreen({super.key});

  @override
  _WarrantyCheckScreenState createState() => _WarrantyCheckScreenState();
}

class _WarrantyCheckScreenState extends State<WarrantyCheckScreen> {
  bool _isPhoneFieldFilled = false;
  bool _isSerialFieldFilled = false;
  final serialController = TextEditingController();
  final phoneController = TextEditingController();
  late ActivateCubit activateCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context);
  }

  void _handlePhoneFieldFilled(bool isFilled) {
    setState(() {
      _isPhoneFieldFilled = isFilled;
    });
  }

  void _handleSerialFieldFilled(bool isFilled) {
    setState(() {
      _isSerialFieldFilled = isFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        title: Text(
          LocaleKeys.searchWarranty.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Image.asset(
                AppIcon.logo,
                height: 80, // Giảm chiều cao của logo
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: AppColors.backgroudWhite,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              LocaleKeys.warrantyChecking.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            CheckFormPhone(
                              isOtherFieldFilled: _isSerialFieldFilled,
                              controller: phoneController,
                               validator: (value) => Validator.checkPhoneNumber(value),
                              onFieldFilled: _handlePhoneFieldFilled,
                            ),
                            const SizedBox(height: 16.0),
                            CheckFormSerial(
                              isOtherFieldFilled: _isPhoneFieldFilled,
                              controller: serialController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return LocaleKeys.serialCannotBeEmpty.tr;
                                }
                                if (value.length < 16 || value.length > 20) {
                                  return LocaleKeys.serial16To20.tr;
                                }
                                return null;
                              },
                              onFieldFilled: _handleSerialFieldFilled,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0), // Adjust padding if needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomOutLineButton(
                                text: LocaleKeys.search.tr,
                                onTap: () {
                                  // Kiểm tra xem liệu ít nhất một trong hai trường đã được điền
                                  if (_isSerialFieldFilled ||
                                      _isPhoneFieldFilled) {
                                    // Nếu có, tiếp tục thực hiện hành động kiểm tra
                                    if (_isSerialFieldFilled) {
                                      activateCubit.getListActivate(
                                          serial: serialController.text);
                                    } else if (_isPhoneFieldFilled) {
                                      activateCubit.getListActivate(
                                          phone: phoneController.text);
                                    }
                                    // Chuyển đến màn hình tiếp theo
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckListScreen()),
                                    );
                                  } else {
                                    // Nếu không, hiển thị thông báo lỗi
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primary,
                                        content: Text(LocaleKeys
                                            .pleaseEnterYourPhoneOrSerial.tr),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      color: AppColors.backgroudWhite,
                      child: FittedBox(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
