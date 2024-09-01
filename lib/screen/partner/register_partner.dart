import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/config/icon.dart';
import 'package:stiebel_etron_warranty/model/register_model.dart';
import 'package:stiebel_etron_warranty/screen/login/login_screen.dart';
import 'package:stiebel_etron_warranty/screen/partner/info_bank.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/screen/widget/dropdown_address.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../widget/custom_text.dart';
import '/service/validator.dart';
import '/service/api.dart';
import 'package:stiebel_etron_warranty/model/address_model.dart';
import '../widget/custom_common.dart';
import 'package:http/http.dart' as http;

class RegisterPartner extends StatefulWidget {
  const RegisterPartner({super.key});

  @override
  State<RegisterPartner> createState() => _RegisterPartnerState();
}

class _RegisterPartnerState extends State<RegisterPartner> {
  final controllerPartnerType = TextEditingController();
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerStoreName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerTaxCode = TextEditingController();
  final controllerStreetName = TextEditingController();
  final controllerAddress = TextEditingController();
  ///
  final controllerCity = TextEditingController();
  final controllerDistrist = TextEditingController();
  final controllerWard = TextEditingController();
  final key = GlobalKey<FormState>();
  List<ListDataAddress> listCity = [];
  List<ListDataAddress> listDistrist = [];
  List<ListDataAddress> listWard = [];

  late AccountCubit accountCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountCubit =
        BlocProvider.of<AccountCubit>(context); // Khởi tạo accountCubit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        title: Text(
          LocaleKeys.registerPartners.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          // decoration: BoxDecoration(
          //   border: Border.all(color: AppColors.primary, width: 2),
          //   borderRadius: BorderRadius.circular(8.0),

          // ),
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdownPartner(
                    icon: Icons.group_sharp,
                    label: LocaleKeys.selectPartnerType.tr,
                    controller: controllerPartnerType,
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerName,
                    typeInput: TypeInput.text,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(fullName: value);
                    },
                    validator: (value) => Validator.checkNull(value,
                        messageErrorNull:
                            LocaleKeys.pleaseEnterYourFullName.tr),
                    labelText: LocaleKeys.fullName.tr,
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerEmail,
                    typeInput: TypeInput.text,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(mail: value);
                    },
                    validator: (value) => Validator.validateEmail(
                      value,
                    ),
                    labelText: "Email *",
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerStoreName,
                    typeInput: TypeInput.text,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(street: value);
                    },
                    validator: (value) => Validator.checkNull(value,
                        messageErrorNull:
                            LocaleKeys.pleaseEnterYourStoreName.tr),
                    labelText: LocaleKeys.storeName.tr,
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerPhone,
                    typeInput: TypeInput.phone,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(phone: value);
                    },
                    validator: (value) => Validator.checkPhoneNumber(value),
                    labelText: LocaleKeys.phoneNumber.tr,
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.assignment_outlined,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerTaxCode,
                    typeInput: TypeInput.text,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(taxCode: value);
                    },
                    validator: (value) => Validator.checkNull(value,
                        messageErrorNull: LocaleKeys.pleaseEnterYourTaxCode.tr),
                    labelText: LocaleKeys.taxCode.tr,
                  ),
                  DropdownAddress(
                    icon: Icons.location_on,
                    type: 'tinh',
                    isRegister: true,
                    controller: controllerCity,
                    controllerDistrist: controllerDistrist,
                    controllerWard: controllerWard,
                    labelText: LocaleKeys.city.tr,
                  ),
                  DropdownAddress(
                    icon: Icons.location_on,
                    type: 'quan',
                    isRegister: true,
                    controller: controllerDistrist,
                    controllerWard: controllerWard,
                    labelText: LocaleKeys.district.tr,
                  ),
                  DropdownAddress(
                    icon: Icons.location_on,
                    type: 'ward',
                    isRegister: true,
                    controller: controllerWard,
                    labelText: LocaleKeys.ward.tr,
                  ),
                  Custom_TextField(
                    prefixIcon: const Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    ),
                    paddingHoz: 10,
                    controller: controllerStreetName,
                    typeInput: TypeInput.text,
                    onChanged: (value) {
                      accountCubit.updateFormRegister(street: value);
                    },
                    validator: (value) => Validator.checkNull(value,
                        messageErrorNull: LocaleKeys.houseNumber.tr),
                    labelText: LocaleKeys.houseNumber.tr,
                  ),
                  const SizedBox(height: 20),
                  InfoBank(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomElevatedButton(
                      text: LocaleKeys.register.tr,
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          print(accountCubit.registerModel.toJson());
                          if (controllerCity.text != '' &&
                              controllerDistrist.text != '' &&
                              controllerWard.text != '') {
                            accountCubit.updateFormRegister(
                                fullAddress:
                                    '${controllerStreetName.text}, ${controllerWard.text}, ${controllerDistrist.text}, ${controllerCity.text}');
                            // Gọi API để tạo mới User
                            print(jsonEncode(accountCubit.registerModel));
                            bool success = await RegisterUserPartner(
                                accountCubit.registerModel);
                            if (success) {
                              Common.showSnackBar(
                                  context, LocaleKeys.registerSuccessfully.tr);
                              // Chuyển đến trang đăng nhập sau khi đăng ký thành công
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            } else {
                              // Hiển thị thông báo lỗi nếu không tạo được người dùng
                              Common.showSnackBar(
                                  context, LocaleKeys.registerFailed.tr);
                            }
                          } else {
                            Common.showSnackBar(
                                context, 'Vui lòng chọn địa chỉ');
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Tạo tài khoản đăng nhập cho đối tác
Future<bool> RegisterUserPartner(RegisterModel registerModel) async {
  final url = Uri.parse(Api.convertURL(Api.apiRegister));
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Chỉ định loại nội dung là JSON
    },
    body: jsonEncode(registerModel),
  );
// statsusCode = 200 hoặc 201 khi đăng ký thành công
  if (response.statusCode == 200) {
    // Giả sử API trả về 200 khi đăng ký thành công
    return true; // await registerUser(registerModel.fullName??'', registerModel.phone??"");
  } else {
    // Xử lý lỗi hoặc trả về false nếu đăng ký không thành công
    return false;
  }
}

// Tạo tài khoản đăng nhập cho đối tác
Future<bool> registerUser(String fullName, String phone) async {
  final url = Uri.parse(Api.convertURL(Api.apiCustomerRegister));
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Chỉ định loại nội dung là JSON
    },
    body: {"fullName": fullName, "phone": phone, "password": phone},
  );
// statsusCode = 200 hoặc 201 khi đăng ký thành công
  if (response.statusCode == 200) {
    // Giả sử API trả về 200 khi đăng ký thành công
    return true;
  } else {
    // Xử lý lỗi hoặc trả về false nếu đăng ký không thành công
    return false;
  }
}

////
class CustomDropdownPartner extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  const CustomDropdownPartner(
      {super.key,
      required this.icon,
      required this.label,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Calculate width as a percentage of screen width
    final width = screenSize.width * 0.78; // e.g., 80% of screen width
    // Adjust height if necessary, or keep it fixed
    const height = 75.0; // e.g., 75 pixels
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary),
            labelText: label,
            
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: <String>[
            'Stielbel',
            LocaleKeys.distributor.tr,
            LocaleKeys.agency.tr,
            LocaleKeys.supermarket.tr,
            LocaleKeys.project.tr,
            LocaleKeys.technical.tr
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,style: const TextStyle(fontSize:14),),
              
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Handle dropdown change
          },
        ),
      ),
    );
  }
}
