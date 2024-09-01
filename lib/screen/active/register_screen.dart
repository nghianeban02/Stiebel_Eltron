import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/screen/active/register_screen_2.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/screen/widget/dropdown_address.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../widget/custom_text.dart';
import '/service/validator.dart';
import '../../model/form_activate_model.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final controllerLastMiddleName = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerProvince = TextEditingController();
  final controllerDistrict = TextEditingController();
  final controllerWard = TextEditingController();
  final controllerStreet = TextEditingController();
  final controllerAddress = TextEditingController();
  late ActivateCubit activateCubit;
  ActiveModel activeModel = ActiveModel();
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context); // Khởi tạo accountCubit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        title:  Text(
         LocaleKeys.registerActivate.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: AppColors.primary, width: 2),
            //   borderRadius: BorderRadius.circular(8.0),

            // ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerLastMiddleName,
                      typeInput: TypeInput.text,
                      validator: (value) => Validator.checkNull(value,
                          messageErrorNull:LocaleKeys.pleaseEnterYourLastMiddleName.tr),
                      labelText:LocaleKeys.lastMiddleName.tr,
                    ),
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerFirstName,
                      typeInput: TypeInput.text,
                      validator: (value) =>
                          Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourFirstName.tr),
                      labelText:LocaleKeys.firstName.tr,
                    ),
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerEmail,
                      typeInput: TypeInput.text,
                      onChanged: (value) {
                        activateCubit.updateFormCustomer(mail: value);
                        // accountCubit.updateFormRegister(taxCode: value);
                      },

                      //validate check định dạng email
                      validator: (value) => Validator.validateEmail(value),
                      labelText: "Mail *",
                    ),
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerPhone,
                      //typeInput: TypeInput.phone, để hiển thị bàn phím số
                      typeInput: TypeInput.phone,
                      onChanged: (value) {
                        activateCubit.updateFormCustomer(phone: value);
                      },
                      validator: (value) => Validator.checkPhoneNumber(value),
                      labelText:LocaleKeys.activationPhoneNumber.tr,
                    ),
                    DropdownAddress(
                      icon: Icons.location_on,
                      type: 'tinh',
                      controller: controllerProvince,
                      controllerDistrist: controllerDistrict,
                      controllerWard: controllerWard,
                      labelText:LocaleKeys.city.tr,
                    ),
                    DropdownAddress(
                      icon: Icons.location_on,
                      type: 'quan',
                      controller: controllerDistrict,
                      controllerWard: controllerWard,
                      labelText: LocaleKeys.ward.tr,
                    ),
                    DropdownAddress(
                      icon: Icons.location_on,
                      type: 'ward',
                      controller: controllerWard,
                      labelText: LocaleKeys.ward.tr,
                    ),
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerStreet,
                      typeInput: TypeInput.text,
                      onChanged: (value) {
                        // accountCubit.updateFormRegister(street: value);
                      },
                      validator: (value) =>
                          Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourStreetName.tr),
                      labelText: LocaleKeys.streetName.tr,
                    ),
                    Custom_TextField(
                      prefixIcon: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                      ),
                      paddingHoz: 10,
                      controller: controllerAddress,
                      typeInput: TypeInput.text,
                      onChanged: (value) {
                        // accountCubit.updateFormRegister(street: value);
                      },
                      validator: (value) =>
                          Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourHouseNumber.tr),
                      labelText: LocaleKeys.houseNumber.tr,
                    ),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      text: LocaleKeys.next.tr,
                      onTap: () {
                        if (key.currentState!.validate()) {
                          if (controllerProvince.text != '' &&
                              controllerDistrict.text != '' &&
                              controllerWard.text != '') {
                            // activateCubit.updateFormCustomer(
                            //   );
                            activateCubit.updateFormCustomer(
                                fullName:
                                controllerLastMiddleName.text + ' ' + controllerFirstName.text,
                                mail: controllerEmail.text,
                                phone: controllerPhone.text,
                                cityName: controllerProvince.text,
                                districtName: controllerDistrict.text,
                                wardName: controllerWard.text,
                                street: controllerStreet.text,
                                addressFull:
                                    '${controllerStreet.text}, ${controllerWard.text}, ${controllerDistrict.text}, ${controllerProvince.text}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegistrationForm2()),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
