import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/screen/start/start_screen.dart';
import 'package:stiebel_etron_warranty/screen/warranty_checking/warranty_checking_screen.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import '../../config/color.dart';
import '../../config/icon.dart';
import '../../config/textstyle.dart';

class ActivationSucces extends StatefulWidget {
  const ActivationSucces({super.key});

  @override
  _ActivationSuccesState createState() => _ActivationSuccesState();
}

class _ActivationSuccesState extends State<ActivationSucces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Image.asset(
                AppIcon.logo,
                height: 100, // Giảm chiều cao của logo
                alignment: Alignment.topCenter,
              ),
            ),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chúc mừng bạn!',
                    style: AppTextStyles.heading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Kích hoạt thành công',
                    style: AppTextStyles.heading,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomOutLineButton(
                    text: 'Trở về',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartScreen()),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  CustomOutLineButton(
                    text: 'Tra cứu',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WarrantyCheckScreen()),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
