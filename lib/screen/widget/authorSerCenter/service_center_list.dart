import 'package:flutter/material.dart';
import 'service_center_item.dart';

class ServiceCenterList extends StatelessWidget {
  final List<Map<String, String>> centers;

  const ServiceCenterList({required this.centers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: centers.length,
        itemBuilder: (context, index) {
          return ServiceCenterItem(
            centerName: centers[index][''] ?? '',
            address: centers[index]['Địa chỉ:'] ?? '',
            hotLine: centers[index]['Hotline:'] ?? '',
          );
        },
      ),
    );
  }
}
