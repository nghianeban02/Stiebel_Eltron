import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/icon.dart';
import '../../config/color.dart';
import '../login/login_screen.dart';
import 'register_partner.dart';
import '../widget/custom_text.dart';
import '/service/validator.dart';



class InfoBank extends StatefulWidget {
  const InfoBank({
    super.key,
  });

  @override
  State<InfoBank> createState() => _InfoBankState();
}

class _InfoBankState extends State<InfoBank> {
  final controllerBankName = TextEditingController();
  final controllerAccountName = TextEditingController();
  final controllerAccountNumber = TextEditingController();

  late AccountCubit accountCubit;
  // final controllerNameProduct = TextEditingController();
  // final controllerDateActivate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accountCubit = BlocProvider.of<AccountCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText().textSize20(title: LocaleKeys.infoBank.tr, color: AppColors.primary, fontWeight: FontWeight.w600),
      const SizedBox(
        height: 10,
      ),
      Custom_TextField(
        prefixIcon: const Icon(
          Icons.business_sharp,
          color: AppColors.primary,
        ),
        onChanged: (value) {
          accountCubit.updateFormRegister(bankName: value);
        },
        paddingHoz: 10,
        controller: controllerBankName,
        typeInput: TypeInput.text,
        validator: (value) => Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourBankName.tr),
        labelText: LocaleKeys.bankName.tr,
      ),
      Custom_TextField(
         prefixIcon: const Icon(
          Icons.edit,
          color: AppColors.primary,
        ),
        onChanged: (value) {
          accountCubit.updateFormRegister(bankAccountNumber: value);
        },
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerAccountNumber,
        validator: (value) => Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourBankAccountNumber.tr),
        typeInput: TypeInput.text,
        labelText: LocaleKeys.bankAccount.tr,
      ),
      Custom_TextField(
         prefixIcon: const Icon(
          Icons.edit,
          color: AppColors.primary,
        ),
        onChanged: (value) {
          accountCubit.updateFormRegister(bankAccountName: value);
        },
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerAccountName,
        validator: (value) => Validator.checkNull(value, messageErrorNull:LocaleKeys.pleaseEnterYourAccountName.tr),
        typeInput: TypeInput.text,
        labelText: LocaleKeys.bankAccountName.tr,
      ),
    ]);
  }
}
