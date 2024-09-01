import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/bloc/warranty_station/warranty_station_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/warranty_station/warranty_station_state.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/model/station_model.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_text.dart';
import 'package:stiebel_etron_warranty/service/launch_url.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

// Định nghĩa widget CustomDropdown
class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? selectedValue;
  final IconData icon;

  CustomDropdown({
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.text),
        floatingLabelStyle: const TextStyle(color: AppColors.primary),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

// Định nghĩa widget AddressSelectionForm
class AddressSelectionForm extends StatefulWidget {
  @override
  _AddressSelectionFormState createState() => _AddressSelectionFormState();
}

class _AddressSelectionFormState extends State<AddressSelectionForm> {
  String? selectedProvince;
  late WarrantyStationCubit warrantyStationCubit;
  List<String> provinces = [];

  @override
  void initState() {
    super.initState();
    loadProvinces();
    warrantyStationCubit = BlocProvider.of<WarrantyStationCubit>(context);
  }

  Future<void> loadProvinces() async {
    final String response = await rootBundle.loadString('assets/json/vn_db.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    setState(() {
      provinces = data.values.map((e) => e['name'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provinces.isEmpty)
            const CircularProgressIndicator()
          else
            CustomDropdown(
              label:LocaleKeys.selectedProvince.tr,
              items: provinces,
              selectedValue: selectedProvince,
              onChanged: (value) {
                setState(() {
                  selectedProvince = value;
                });
                warrantyStationCubit.updateSelectedProvince(selectedProvince!);
              },
              icon: Icons.location_on,
            ),
        ],
      ),
    );
  }
}

itemlist(StationModel stationModel) {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.5),
          border: Border.all(color: AppColors.primary.withOpacity(1.0), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText().textSize18(title: stationModel.name),
          callPhone(stationModel.phone ?? ''),
          address(stationModel)
        ],
      ),
    ).paddingTop(6),
  );
}

callPhone(String text) {
  List listPhone = text.contains('/') ? text.split('/') : text.split(',');
  print(listPhone);
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.phone,
            size: 15,
            color: AppColors.grey,
          ),
          for (int i = 0; i < listPhone.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText().textSize14(text: listPhone[i]).withWidth(120).onTap(() {
                  CustomURL().launchCaller(listPhone[i]);
                })
              ],
            ),
        ],
      ).paddingSymmetric(vertical: 5).paddingRight(10));
}

address(StationModel stationModel) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.location_city,
        size: 15,
        color: AppColors.grey,
      ),
      Expanded(child: CustomText().textSize14(text: stationModel.addressFull)),
    ],
  ).paddingSymmetric(vertical: 5).onTap(() {
    MapsLauncher.launchQuery(stationModel.addressFull ?? '');
  });
}
