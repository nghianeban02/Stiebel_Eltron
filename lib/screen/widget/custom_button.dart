import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/color.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({super.key, required this.text, required this.onTap, this.color, this.width, this.outlineColor, this.textColor});
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? outlineColor;
  final Color? textColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width ?? 150.w,
      height: 50,
      color: color ?? AppColors.primary,
      shape: RoundedRectangleBorder(side: BorderSide(color: outlineColor ?? AppColors.primary), 
      borderRadius: const BorderRadius.all(Radius.circular(16.5))),
      textColor: textColor ?? AppColors.white,
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}

/// EvelatedButton
class CustomElevatedButton extends StatelessWidget {
   final String text;
  final VoidCallback onTap;
  const CustomElevatedButton({super.key, required this.text, required this.onTap, });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text,
            style: const 
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.white
              ),
          ),
        ),
       
      ),
    );
  }
}

//OutLineButton
class CustomOutLineButton extends StatelessWidget {
   final String text;
  final VoidCallback onTap;
  const CustomOutLineButton({super.key, required this.text, required this.onTap, });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: OutlinedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          )
        ),
        child: Text(
          text,
          style: const 
          TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.titleColor
            ),
        ),
       
      ),
    );
  }
}

//OutLineButton Icon Left

// class CustomOutLineButtonLeft extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;

//   const CustomOutLineButtonLeft({
//     Key? key,
//     required this.text,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: 150,
//       child: OutlinedButton(
//         onPressed: onTap,
//         style: OutlinedButton.styleFrom(
//           side: const BorderSide(color: AppColors.primary),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.arrow_back, color: AppColors.titleColor),
//             const SizedBox(width: 8),
//             Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.titleColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// //OutLineButton Icon Right


// class CustomOutLineButtonRight extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
  
//   const CustomOutLineButtonRight({
//     Key? key,
//     required this.text,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: 150,
//       child: OutlinedButton(
//         onPressed: onTap,
//         style: OutlinedButton.styleFrom(
//           side: const BorderSide(color: AppColors.primary),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.titleColor,
//               ),
//             ),
//             const SizedBox(width: 8),
//             const Icon(Icons.arrow_forward, color: AppColors.titleColor),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 170,
      child: TextButton(
        onPressed: onTap,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
