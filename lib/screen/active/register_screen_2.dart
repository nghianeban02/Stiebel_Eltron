import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/config/textstyle.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:stiebel_etron_warranty/screen/active/active_succes.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/service/validator.dart';
import '../../config/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text.dart';
import 'register_screen.dart';
import '../active/select_image.dart';
import 'register_screen.dart';

class RegistrationForm2 extends StatefulWidget {
  RegistrationForm2({
    super.key,
  });

  @override
  State<RegistrationForm2> createState() => _RegistrationForm2State();
}

class _RegistrationForm2State extends State<RegistrationForm2> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  final serialController = TextEditingController();
  final productController = TextEditingController();
  final modelController = TextEditingController();
  final placeController = TextEditingController();
  final dateController = TextEditingController();
  late ActivateCubit activateCubit;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context);
    print(activateCubit.customer.toJson());
    //activateCubit = BlocProvider.of<ActivateCubit>(context); // Khởi tạo accountCubit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          LocaleKeys.registerActivate.tr,
          style: AppTextStyles.titleAppbar,
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        // foregroundColor: AppColors.textRed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                // Custom_TextField(
                //   typeInput: TypeInput.text,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Serial không được để trống';
                //     }
                //     if (value.length < 16 || value.length > 20) {
                //       return 'Serial phải từ 16-20 số';
                //     }
                //     return null;
                //   },
                //   controller: serialController,
                //   prefixIcon: const Icon(
                //     Icons.edit,
                //     color: AppColors.primary,
                //   ),
                //   labelText: 'Serial từ 16-20 số',
                //   onChanged: (value) {
                //     activateCubit.updateFormProduct(serial: value);
                //   },
                // ),
                Custom_TextField(
                  typeInput: TypeInput.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.serialCannotBeEmpty.tr;
                    }
                    if (value.length < 16 || value.length > 20) {
                      return LocaleKeys.serial16To20.tr;
                    }
                    return null;
                  },
                  controller: serialController,
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.primary,
                  ),
                  labelText:LocaleKeys.serial16To20.tr,
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
                      selection:
                          TextSelection.collapsed(offset: newValue.length),
                    );
                    activateCubit.updateFormProduct(serial: newValue);
                  },
                ),
                Custom_TextField(
                  typeInput: TypeInput.text,
                  validator: (value) => Validator.checkNull(value,
                      messageErrorNull:LocaleKeys.pleaseEnterYourProduct.tr),
                  controller: productController,
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.primary,
                  ),
                  labelText:LocaleKeys.product.tr,
                ),
                Custom_TextField(
                  typeInput: TypeInput.text,
                  validator: (value) => Validator.checkNull(value,
                      messageErrorNull:LocaleKeys.pleaseEnterModel.tr),
                  controller: modelController,
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: AppColors.primary,
                  ),
                  labelText:LocaleKeys.model.tr,
                  onChanged: (value) {
                    activateCubit.updateFormProduct(modelId: int.parse(value));
                  },
                ),
                //Place Buy
                // Custom_TextField(
                //   typeInput: TypeInput.text,
                //   validator: (value)=> Validator.checkNull(value,messageErrorNull: 'Vui lòng nhập nơi mua'),
                //   controller: placeController,
                //   prefixIcon: const Icon(Icons.location_on,
                //   color: AppColors.primary,
                //   ),
                //   labelText: 'Nơi mua',
                //   onChanged: (value){
                //     activateCubit.updateFormProduct(place: value);
                //   },
                // ),
                // Custom_TextField(
                //   typeInput: TypeInput.text,
                //   controller: dateController,
                //   validator: (value)=> Validator.checkNull(value,messageErrorNull: 'Vui lòng nhập ngày mua'),

                //   prefixIcon: const Icon(Icons.calendar_month,
                //   color: AppColors.primary,
                //   ),
                //   labelText: 'Ngày mua',
                //   onChanged: (value) {
                //     activateCubit.updateFormProduct(dayBuy: value);
                //   },
                // ),
                pickerDate(
                  iconData: Icons.calendar_month,
                  lable: LocaleKeys.dayBuy.tr,
                  controller: dateController,
                  checkOpen: true,
                  onTap: () async {
                    DateTime? day = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                      selectableDayPredicate: (day) =>
                          day.isBefore(DateTime.now()),
                    );

                    dateController.text =
                        day != null ? Utils().convertDate(day) : "";
                    activateCubit.updateFormProduct(
                        dayBuy: Utils().convertDateSytem(dateController.text));
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                 Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SelectImage(title:LocaleKeys.warranttyCard.tr),

                      SelectImage(title:LocaleKeys.purchaseInvoice.tr)
                      // UploadButton(label: 'Phiếu bảo hành'),
                      //   SizedBox(height: 15),
                      // UploadButton(label: 'Hoá đơn mua hàng'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                    title:  Text(
                      LocaleKeys.agreeInfo.tr,
                      textAlign: TextAlign.justify,
                    ),
                    value: _isChecked1,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked1 = newValue ?? false;
                      });
                      // Handle checkbox state change
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                    title:  Text(
                      LocaleKeys.agreeActive.tr,
                      textAlign: TextAlign.justify,
                    ),
                    value: _isChecked2,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked2 = newValue ?? false;
                      });
                      // Handle checkbox state change
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutLineButton(
                      text: LocaleKeys.back.tr,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationForm()),
                        );
                      },
                    ),
                    CustomElevatedButton(
                      text: LocaleKeys.send.tr,
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          if (_isChecked1 == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(
                                        LocaleKeys.pleaseAgreeInfo.tr)));
                          } else if (_isChecked2 == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(
                                        LocaleKeys.pleaseAgreeActive.tr)));
                          } else {
                            //   print(activateCubit.formActivate.toJson());
                            activateCubit.addActivate();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const ActivationSucces()),
                            // );
                          }
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget pickerDate(
    {required IconData iconData,
    required String lable,
    required TextEditingController controller,
    required bool checkOpen,
    bool isFrom = false,
    VoidCallback? onTap}) {
  return Custom_TextField(
      prefixIcon: Icon(
        iconData,
        color: AppColors.primary,
      ),
      controller: controller,
      readOnly: true,
      typeInput: TypeInput.text,
      labelText: lable,
      paddingHoz: 20,
      // decoration: InputDecoration(
      //   contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      //   label: Text(lable),
      // ),
      onTap: onTap);
}
