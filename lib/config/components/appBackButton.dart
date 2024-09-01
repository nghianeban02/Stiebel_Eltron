import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stiebel_etron_warranty/config/icon.dart';

import '../color.dart';


class AppBackButton extends StatelessWidget {
  /// Custom Back labelLarge with a custom ICON for this app
  const AppBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.primary,
      onPressed: () => Navigator.pop(context),
    );
  }
}
class AppButtonNotification extends StatelessWidget {
  /// Custom Back labelLarge with a custom ICON for this app
  const AppButtonNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notification_add_outlined),
      onPressed: () => Navigator.pop(context),
    );
  }
}
