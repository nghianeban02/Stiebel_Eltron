import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/page/user/profileUser.dart';
import '../navigator/app_router.dart';
import '../screen/login/login_screen.dart';


class AppRoutesConf {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    dynamic symbol = settings.arguments;
    dynamic router = settings.name;
    switch (router) {
      case AppRouter.loginScreen:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
      // case AppRouter.registerScreen:
      //   return MaterialPageRoute<void>(
      //     settings: settings,
      //     builder: (BuildContext context) => const RegisterScreen(),
      //   );
    //   case AppRouter.registerCustomerScreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const RegisterCustomerScreen(),
    //     );
    //   case AppRouter.homeScreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const HomeScreen(),
    //     );
    //   case AppRouter.historyActivateScreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const HistoryActivateScreen(),
    //     );
    //   case AppRouter.notificationScreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const NewsScreen(),
    //     );
    //   case AppRouter.activateSreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => ActivateScreen(),
    //     );
    //   case AppRouter.warrantyStation:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => WarrantyStation(),
    //     );
    //   // case AppRouter.searchActivate:
    //   //   return MaterialPageRoute<void>(
    //   //     settings: settings,
    //   //     builder: (BuildContext context) => SearchActivateScreen(),
    //   //   );

      case AppRouter.userInfo:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const ProfileUser(),
        );
    //   case AppRouter.changePasswordScreen:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const ChangePasswordScreen(),
    //     );
    //   case AppRouter.registerMain:
    //     return MaterialPageRoute<void>(
    //       settings: settings,
    //       builder: (BuildContext context) => const RegisterMain(),
    //     );
    //   // case AppRouter.accountScreen:
    //   //   return MaterialPageRoute<void>(
    //   //     settings: settings,
    //   //     builder: (BuildContext context) => const AccountScreen(),
    //   //   );
    //   // case AppRouter.confirmOtp:
    //   //   return MaterialPageRoute<void>(
    //   //     settings: settings,
    //   //     builder: (BuildContext context) => ConfirmOtp(
    //   //       typeOTP: symbol == null ? false : symbol['typeOTP'],
    //   //       phone: symbol == null ? '' : symbol['phone'],
    //   //       password: symbol == null ? '' : symbol['password'],
    //   //     ),
    //   //   );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text("Not found screen"),
            ),
          ),
        );
    // }
  }
}
}