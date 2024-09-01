import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/page/mainpage/hompage.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/service/validator.dart';
import '../forget_password/forget_password_screen.dart';
import '../login/login_screen.dart';
import '/config/color.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const homePage()));
          },
        ),
        title:  Text(
          LocaleKeys.changePassword.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Custom_TextField(
                paddingHoz: 0,
                controller: _oldPasswordController,
                typeInput: TypeInput.password,
                labelText:LocaleKeys.oldPassword.tr,
                validator: (value) => Validator.checkPassword(value),
              ),
              Custom_TextField(
                paddingHoz: 0,
                controller: _newPasswordController,
                typeInput: TypeInput.password,
                labelText: LocaleKeys.newPassword.tr,
                validator: (value) => Validator.checkPassword(value),
              ),
              Custom_TextField(
                paddingHoz: 0,
                controller: _confirmPasswordController,
                typeInput: TypeInput.confirmPassword,
                labelText: LocaleKeys.confirmPassword.tr,
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return LocaleKeys.passwordNotMatch.tr;
                  }
                  return Validator.checkNull(value,
                      messageErrorNull: LocaleKeys.pleaseEnterYourPassword.tr,
                      maxChar: 50);
                },
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  text: LocaleKeys.forgotPassword.tr,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordResetForm()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: CustomElevatedButton(
                  text: LocaleKeys.changePassword.tr,
                  onTap: () {
                    if (key.currentState!.validate()) {
                      BlocProvider.of<AccountCubit>(context).changePassword(
                          _oldPasswordController.text, _newPasswordController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
