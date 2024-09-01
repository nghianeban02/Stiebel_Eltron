import 'package:flutter/material.dart';
import '/config/icon.dart';

class MenuHome extends StatefulWidget {
  bool isDoiTac; 
   MenuHome({super.key,required this.isDoiTac});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}
class _MenuHomeState extends State<MenuHome> {
  final listIconMenu = [AppIcon.warranty,AppIcon.search, AppIcon.chart, Icons.policy];
  final listTitleMenu = ['Kích hoạt bảo hành', 'Tra cứu bảo hành', 'Thống kê kích hoạt', 'Chính sách bảo hành'];
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}