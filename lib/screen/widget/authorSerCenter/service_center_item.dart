import 'package:flutter/material.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/config/icon.dart';

class ServiceCenterItem extends StatelessWidget {
  final String centerName;
  final String address;
  final String hotLine;

  const ServiceCenterItem({
    required this.centerName,
    required this.address,
    required this.hotLine,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10.0),
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      subtitle: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(centerName),
            Text(address),
            Text(hotLine),
          ],
        ),
      ),
      isThreeLine: true,
    );
  }
}

Widget _buildServiceCenterItem() {
  return ListView(
    children: const [
      ServiceCenterItem(
        centerName: "CÔNG TY TNHH STIEBEL ELTRON VIỆT NAM",
        address: "Khu thương mại – dịch vụ số 0.03 Tháp B1 – Khu chung cư phức hợp Lô M2 (Sarimi) số 72 Nguyễn Cơ Thạch, Phường An Lợi Đông, Thành phố Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam",
        hotLine: " 1800888822",
      ),
      ServiceCenterItem(
        centerName: "TRUNG TÂM BẢO HÀNH PHÚ ĐẠT - PHÚ THỌ",
        address: "1239 Hùng Vương, phường Cát Tiên, TP. Việt Trì, Phú Thọ",
        hotLine: "02103850877",
      ),
      ServiceCenterItem(
        centerName: "TRUNG TÂM BẢO HÀNH NGUYỄN HOÀNG - LONG AN",
        address: " 63 Hùng Vương, phường 2, TP. Tân An, Long An",
        hotLine: "0918616676",
      ),
      ServiceCenterItem(
        centerName: "Tên Trung tâm 4",
        address: "Địa chỉ 4",
        hotLine: "Số điện thoại 4",
      ),
    ],
  );
}

