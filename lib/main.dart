import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/translations.dart';
import 'package:stiebel_etron_warranty/navigator/router_config.dart';
import 'package:stiebel_etron_warranty/page/mainpage/hompage.dart';
import 'package:stiebel_etron_warranty/page/startScreen/splashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stiebel_etron_warranty/screen/start/start_screen.dart';
import 'package:stiebel_etron_warranty/service/network_status.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/wrap_provide.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import './config/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   AppTranslations.loadTranslations();
   AppPreferencesImpl().init();
  runApp(ScreenUtilInit(
      designSize: const Size(414, 902), minTextAdapt: true, splitScreenMode: true, builder: (ctx, child) => const WrapProvider(child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutesConf router = AppRoutesConf();
  @override
  void initState() {
    super.initState();
    //AppPreferencesImpl().init();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return NetworkStatus(
        child: GetMaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.white, iconTheme: IconThemeData(color: AppColors.primary)),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          primaryColor: AppColors.primary,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.white.withOpacity(0.6),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.darkBlue),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              labelStyle: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500, fontSize: 14))),
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      navigatorKey: NavigateKeys().navigationKey,
      onGenerateRoute: router.onGenerateRoute,
      home: splashScreen(),
      translations:AppTranslations(),
      locale: Locale('vi', 'VN'), // Ngôn ngữ mặc định
      fallbackLocale: Locale('vi', 'VN'), // Ngôn ngữ dự phòng
    ));
  }
  }
class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class NavigateKeys {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navKey;
}

