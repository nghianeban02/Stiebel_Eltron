import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../service/validator.dart';
import '/config/color.dart';
import '/screen/login/login_screen.dart';


class PasswordResetForm extends StatefulWidget {
  @override
  _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();
  final  emailController = TextEditingController();
 late AccountCubit accountCubit ;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text(
            LocaleKeys.forgotPassword.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.backgroudWhite,
          foregroundColor: AppColors.textRed,
        ),
      body: Padding(
        padding:  const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
               Text(
                LocaleKeys.enterEmail.tr,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                validator:(value) => 
                Validator.validateEmail(value),
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Email',
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: AppColors.primary,),
                ),
                keyboardType: TextInputType.phone,
                
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomElevatedButton(text:LocaleKeys.send.tr, onTap: () {
                    if (_formKey.currentState!.validate()) {
                      accountCubit.fogetPassword(emailController.text);
                    }
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
