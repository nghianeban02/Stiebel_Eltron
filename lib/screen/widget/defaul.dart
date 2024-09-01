import 'package:flutter/material.dart';

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key,required this.titel});
  final String titel;
  // khi dung tham so truyen vao phai khia bao bien trung ten require
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titel,
            style: const TextStyle(fontSize: 30),)],),
    );
  }
}