import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import '../../warranty_checking/list_checking_screen.dart';



class CheckButton extends StatelessWidget {
  const CheckButton({
    Key? key,
    // required this.onPressed,
  }) : super(key: key);

  //  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding if needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutLineButton(text: 'Kiểm tra', onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CheckListScreen()),
                            );
                          },)
          ],
        ),
      ),
    );
  }
}


