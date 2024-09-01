import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/navigator/app_router.dart';
import 'package:stiebel_etron_warranty/page/mainpage/mainpage.dart';
import 'package:stiebel_etron_warranty/screen/start/start_screen.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import '../config/components/appBackButton.dart';
import '../config/components/appDefaults.dart';
import '../config/icon.dart';
import '../screen/ activation_statistics/ activation_statistics_screen.dart';
import '../screen/active/register_screen.dart';
import '../screen/authorized_service_center/author_ser_center_screen.dart';
import '../screen/change_password/change_password.dart';
import '../screen/login/login_screen.dart';
import '../screen/news_notification/news_notification_screen.dart';
import '../screen/policy_term_screen/policy_term_screen.dart';
import '../screen/warranty_checking/warranty_checking_screen.dart';
import '../screen/widget/custom_button.dart';
import '../screen/widget/custom_text.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              SizedBox(
                height: 100.0, // Chiều cao cố định cho DrawerHeader
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250, // Chiều rộng của logo
                        height: 50, // Chiều cao của logo
                        child: Image.asset('assets/icon/logoSE.png'),
                      ),
                      const SizedBox(height: 1),
                      // const Text(
                      //   'Tên đại lý',
                      //   style: TextStyle(
                      //     fontSize: 18.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              AppSettingsListTile(
                label: LocaleKeys.home.tr,
                leading: SvgPicture.asset(AppIcon.home, color: AppColors.primary),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const mainPage())),
              ),
              // AppSettingsListTile(
              //   label: 'Kích hoạt bảo hành',
              //   leading: SvgPicture.asset(AppIcon.warranty, color: AppColors.primary),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationForm())),
              // ),
              // AppSettingsListTile(
              //   label: 'Tra cứu bảo hành',
              //   leading: SvgPicture.asset(AppIcon.search, color: AppColors.primary),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WarrantyCheckScreen())),
              // ),
              // AppSettingsListTile(
              //   label: 'Thống kê kích hoạt',
              //   leading: SvgPicture.asset(AppIcon.chart, color: AppColors.primary),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ActivationStatistic())),
              // ),
              AppSettingsListTile(
                label: LocaleKeys.warrantyStation.tr,
                leading: SvgPicture.asset(AppIcon.shield, color: AppColors.primary),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorServiceCenterScreen())),
              ),
              // AppSettingsListTile(
              //   label: 'Thông báo',
              //   leading: SvgPicture.asset(AppIcon.notification, color: AppColors.primary),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsandNotificationScreen())),
              // ),
              AppSettingsListTile(
                label:LocaleKeys.personalInfomation.tr,
                leading: SvgPicture.asset(AppIcon.user, color: AppColors.primary),
                onTap: () => Navigator.pushNamed(context, AppRouter.userInfo),
              ),
              // AppSettingsListTile(
              //   label: 'Thay đổi ngôn ngữ',
              //   leading: SvgPicture.asset(AppIcon.languages, color: AppColors.primary),
              //   onTap: () => _showLanguageDialog(context),
              // ),
              AppSettingsListTile(
                label: LocaleKeys.policyandTerms.tr,
                leading: SvgPicture.asset(AppIcon.policy, color: AppColors.primary),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PolicyTermsScreen())),
              ),
              // AppSettingsListTile(
              //   label: LocaleKeys.changeLanguage.tr,
              //   leading: SvgPicture.asset(AppIcon.languages, color: AppColors.primary),
              //   onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PolicyTermsScreen())),
              // ),
              
               AppSettingsListTile(
                label:LocaleKeys.changePassword.tr,
                leading: SvgPicture.asset(AppIcon.changeuser, color: AppColors.primary),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen())),
              ),
              // AppSettingsListTile(
              //   label: 'Thay đổi ngôn ngữ',
              //   leading: SvgPicture.asset(AppIcon.languages, color: AppColors.primary),
              //   onTap: () => _showLanguageDialog(context),
              // ),
              AppSettingsListTile(
                label: LocaleKeys.delete.tr,
                leading: SvgPicture.asset(AppIcon.delete, color: AppColors.primary),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: BaseButton(
                                  text: LocaleKeys.cancel.tr,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  color: AppColors.white,
                                  textColor: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10), // Thêm khoảng cách giữa các nút
                              Expanded(
                                child: BaseButton(
                                  text: LocaleKeys.delete.tr,
                                  onTap: () {
                                    String token = AppPreferencesImpl().getToken!;
                                    BlocProvider.of<AccountCubit>(context).setStatus(token);
                                    //accountCubit.deleteAccount(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                        content: CustomText().textSize14(
                          text: LocaleKeys.confirmDelete.tr,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(LocaleKeys.notification.tr),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              AppSettingsListTile(
                label: LocaleKeys.logout.tr,
                leading: SvgPicture.asset(AppIcon.logout, color: AppColors.primary),
                onTap: () {
                  AppPreferencesImpl().setToken('');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreen()));
                } ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppSettingsListTile extends StatelessWidget {
  final String label;
  final Widget leading;
  final VoidCallback? onTap;

  const AppSettingsListTile({
    Key? key,
    required this.label,
    required this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
      leading: leading,
      title: Text(label),
      onTap: onTap,
    );
  }
}
