import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/cubit/login_cubit.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../page/mainpage/mainpage.dart';
import '../forget_password/forget_password_screen.dart';
import '../start/start_screen.dart';
import '/config/color.dart';
import '/config/icon.dart';
import '/service/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  late LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = BlocProvider.of<LoginCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize= MediaQuery.of(context).size;
    final textFieldWidth = screenSize.width * 0.9;
    final textFieldHeight = screenSize.height * 0.08;
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.titleColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartScreen()));
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Image(image: AssetImage(AppIcon.logo), height: 200),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: AppColors.backgroudWhite,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: AppColors.primary, width: 2),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 25),
                                SizedBox(
                                  width: textFieldWidth,
                                  height:textFieldHeight,
                                  child: TextFormField(
                                    validator: (value) =>
                                        Validator.checkNull(value),
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: AppColors.titleColor,
                                      ),
                                      labelText:LocaleKeys.username.tr,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: textFieldWidth,
                                  height:textFieldHeight,
                                  child: TextFormField(
                                    controller: _passwordController,
                                    // validator: (value) =>
                                    //     Validator.checkPassword(value),
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: AppColors.titleColor,
                                      ),
                                      labelText: LocaleKeys.password.tr,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.titleColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextButton(
                                    text:LocaleKeys.forgotPassword.tr,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 PasswordResetForm()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          color: AppColors.backgroudWhite,
                          child:  FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              LocaleKeys.parterLogin.tr,
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutLineButton(
                      text: LocaleKeys.back.tr,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartScreen()),
                        );
                      },
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const mainPage()));
                        } else if (state is LoginError) {
                          // Hiển thị SnackBar ở đây
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(LocaleKeys.invalidAccountInfomation.tr),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      },
                      builder: (BuildContext context, LoginState state) {
                        if (state is LoginLoading) {
                          if (state.isLoading == true) {
                            return const CircularProgressIndicator();
                          }
                        }
                        // Bỏ phần hiển thị SnackBar ở đây
                        return CustomElevatedButton(
                          text: LocaleKeys.login.tr,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _loginCubit.login(_phoneController.text,
                                  _passwordController.text);
                            }
                          },
                        );
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
