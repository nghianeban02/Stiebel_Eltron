import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/page/mainpage/hompage.dart';
import 'package:stiebel_etron_warranty/page/mainpage/mainpage.dart';
import 'package:stiebel_etron_warranty/screen/authorized_service_center/author_ser_center_screen.dart';
import 'package:stiebel_etron_warranty/screen/login/login_screen.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import '../ activation_statistics/ activation_statistics_screen.dart';
import '../active/register_screen.dart';
import '../partner/register_partner.dart';
import '../warranty_checking/warranty_checking_screen.dart';
import '/config/icon.dart';
import '/config/color.dart';
import 'package:http/http.dart' as http;

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Adjust height as necessary
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppIcon.logo,
                height: 150, // Giảm chiều cao của logo
                alignment: Alignment.topCenter,
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Prevent scrolling inside GridView
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  _buildGridButton(AppIcon.logoutpng, LocaleKeys.login.tr, () {
                    if (AppPreferencesImpl().getToken != '') {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const mainPage()));
                    } else {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    }
                  }),
                  _buildGridButton(AppIcon.groupuser, LocaleKeys.registerPartners.tr, () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegisterPartner()));
                  }),
                  _buildGridButton(AppIcon.warrantypng,LocaleKeys.registerActivate.tr, () {
                    //Navigator.pushNamed(context, '/activateWarranty');
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegistrationForm()));
                  }),
                  _buildGridButton(AppIcon.searchpng, LocaleKeys.searchWarranty.tr, () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => WarrantyCheckScreen()));
                  }),
                  _buildGridButton(AppIcon.shieldpng, LocaleKeys.warrantyStation.tr, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthorServiceCenterScreen()));

                  }),
                  _buildGridButton(AppIcon.languagespng, LocaleKeys.changeLanguage.tr, () {
                    _showLanguageDialog(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => StartScreen()));
                  }), //, isLogo: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridButton(String? iconPath, String text, VoidCallback onPressed,
    {bool isLogo = false}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Get screen width
      double screenWidth = MediaQuery.of(context).size.width;

      // Determine icon size and padding based on screen width
      double iconWidth = isLogo ? (screenWidth * 0.4) : (screenWidth * 0.1);
      double iconHeight = isLogo ? (screenWidth * 0.35) : (screenWidth * 0.1);
      double padding = screenWidth * 0.02;

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: EdgeInsets.all(padding),
          ),
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconPath != null)
                Image.asset(
                  iconPath,
                  width: iconWidth,
                  height: iconHeight,
                ),
              Padding(padding: EdgeInsets.only(top: padding)),
              Text(
                text,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(LocaleKeys.changeLanguage.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(LocaleKeys.english.tr),
              onTap: () {
                Get.updateLocale(Locale('en', 'US'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(LocaleKeys.vietnamese.tr),
              onTap: () {
                Get.updateLocale(Locale('vi', 'VN'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(LocaleKeys.german.tr),
              onTap: () {
                Get.updateLocale(Locale('ge', 'GN'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
}
