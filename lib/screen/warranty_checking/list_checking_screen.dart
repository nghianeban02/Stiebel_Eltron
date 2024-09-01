import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/screen/warranty_checking/warranty_checking_screen.dart';
import 'package:stiebel_etron_warranty/screen/widget/warrantyChecking/boder_list_warranty.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../../config/icon.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({super.key});

  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  late ActivateCubit activateCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context)..getListActivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Text(
          LocaleKeys.searchWarranty.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: Center(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Image.asset(
                AppIcon.logo,
                height: 80, // Giảm chiều cao của logo
                alignment: Alignment.topCenter,
              ),
            ),
            Expanded(
              child: ListView.builder(
              itemCount: activateCubit.listActivate.length,
              // physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(15.0),
                  child: BorderListWarranty(
                    listDataActive: activateCubit.listActivate[index],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
