import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/page/mainpage/hompage.dart';
import 'package:stiebel_etron_warranty/page/user/profileUser.dart';
import 'package:stiebel_etron_warranty/screen/login/login_screen.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import '../../config/color.dart';
import '../../menu/navigationBar.dart';
import '../../screen/ activation_statistics/ activation_statistics_screen.dart';
import '../../screen/active/register_screen.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';

import '../../screen/warranty_checking/warranty_checking_screen.dart';
import '../../screen/widget/defaul.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int _selectdIndex = 0;
late AccountCubit accountCubit;
  void _onItemTapped(int index){
    setState(() {
      _selectdIndex = index;
    });
    
  }
  _loadWidget(int index){
    var nameWidgets = "Trang chủ";
    switch (index){
      case 0: 
        return homePage();
      case 1:
       return RegistrationForm();
      case 2:
       return WarrantyCheckScreen();
      case 3:
        return ActivationStatistic();
      default:
        nameWidgets = "None";
        break;
    }
    return DefaultWidget(titel: nameWidgets);
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      drawer: Drawer(
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
                      const Text('Tên đại lý',style: TextStyle(
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold,),
                        ),
                    ],
                  ),
                ),
              ),
            ListTile(
              leading: const Icon(Icons.home),
              title:  Text(LocaleKeys.home.tr),
              onTap: (){
                Navigator.pop(context);
                _selectdIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Kích hoạt bảo hành'),
              onTap: (){
                Navigator.pop(context);
                _selectdIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Tra cứu bảo hành'),
              onTap: (){
                Navigator.pop(context);
                _selectdIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Thống kê kích hoạt'),
              onTap: (){
                Navigator.pop(context);
                _selectdIndex = 3;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trạm bảo hành'),
              onTap: (){
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Thông báo'),
              onTap: (){
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Thông tin cá nhân'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileUser())),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Chính sách và điều khoản'),
              onTap: (){
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Đổi mật khẩu'),
              onTap: (){
               
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title:  Text('Thay đổi ngôn ngữ'.tr),
              onTap: (
              ){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thay đổi ngôn ngữ'.tr),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('English'),
                            onTap: () {
                              Get.updateLocale(Locale('en', 'US'));
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('Vietnamese'),
                            onTap: () {
                              Get.updateLocale(Locale('vi', 'VN'));
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            title: Text('German'),
                            onTap: () {
                              Get.updateLocale(Locale(
                                  'de', 'DE')); // Corrected 'ge' to 'de' for German
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ), 
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text('Xóa tài khoản'),
            //   onTap: (
            //   ){
            //      accountCubit.deleteAccount(context);
            //   },
            // ), 
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Đăng xuất'),
              onTap: () {
                AppPreferencesImpl().setToken('');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));} 
            ), 
            ],),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _selectdIndex,
        onNavTap: (int index) {
          _onItemTapped(index);
        },
      ),
      body: _loadWidget(_selectdIndex),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (Get.locale?.languageCode == 'en') {
      //       Get.updateLocale(Locale('vi', 'VN'));
      //     } else {
      //       Get.updateLocale(Locale('en', 'US'));
      //     }
      //   },
      //   child: Icon(Icons.language),
      // ),
    );
  }
}

