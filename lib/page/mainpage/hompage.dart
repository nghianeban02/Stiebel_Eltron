import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/cubit/login_cubit.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/menu/drawerPage.dart';
import 'package:stiebel_etron_warranty/page/mainpage/listProduct.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../screen/news_notification/news_notification_screen.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late LoginCubit loginCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginCubit=BlocProvider.of<LoginCubit>(context)..getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.home.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.primary, // Đặt màu đỏ cho icon menu
        ),
        actions: <Widget>[
          IconButton(
            icon:  Image.asset(
              'assets/icon/languages.png',
              width: 30,
              height: 30,
            ),
            color: AppColors.primary,
            onPressed: () {
               _showLanguageDialog(context);
            },
          ),
        ],
      ),
      drawer: const Drawer(child: DrawerPage()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel
            CarouselSlider(
              items: [
                'assets/images/poster1.jpg',
                'assets/images/poster2.jpg',
                'assets/images/poster3.jpg'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(i),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            ListProduct(),
          ],
        ),
        
        
      ),
                     //  ListProduct ()    

    );
  }
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
