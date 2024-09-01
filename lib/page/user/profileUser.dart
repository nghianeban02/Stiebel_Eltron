import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_state.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/model/info_user_model.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_button.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_text.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  late InfoUserModel infoUserModel;
  late AccountCubit accountCubit;
  final key = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerBankName = TextEditingController();
  final controllerAccountNumber = TextEditingController();
  bool isDoiTac = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  Future getUserInfo() async {
    accountCubit = BlocProvider.of<AccountCubit>(context);
    await accountCubit.getUserInfo();
    infoUserModel = accountCubit.infoUserModel;
    isDoiTac = infoUserModel.idGroupUser == 'DOITAC';
    if (infoUserModel.staff != null) {
      controllerName.text = infoUserModel.staff!.fullName ?? '';
      controllerPhone.text = infoUserModel.staff!.phone ?? '';
      controllerAddress.text = infoUserModel.staff!.fullAddress ?? '';
      controllerEmail.text = infoUserModel.staff!.mail ?? '';
    } else {
      controllerName.text = infoUserModel.fullname ?? '';
      controllerPhone.text = infoUserModel.username ?? '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.personalInfomation.tr),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.white,
          child: Form(
            key: key,
            child: SingleChildScrollView(
                child: BlocBuilder<AccountCubit, AccountState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/male-avatar-icon-flat-style-male-user-icon-cartoon-man-avatar-hipster-vector-stock-91462914.jpg'),
                      ),
                    ),
                  ),
                  Custom_TextField(
                    paddingVer: 15,
                    controller: controllerName,
                    typeInput: TypeInput.text,
                    labelText: LocaleKeys.fullName.tr,
                  ),
                  Custom_TextField(
                    paddingVer: 15,
                    controller: controllerPhone,
                    typeInput: TypeInput.phone,
                    labelText: LocaleKeys.phoneNumber.tr,
                    readOnly: true,
                  ),
                  if (isDoiTac) ...{
                    Custom_TextField(
                      paddingVer: 15,
                      controller: controllerEmail,
                      typeInput: TypeInput.text,
                      labelText: 'Email',
                    ),
                    Custom_TextField(
                      paddingVer: 15,
                      controller: controllerAddress,
                      typeInput: TypeInput.text,
                      labelText: LocaleKeys.address.tr,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16.0, vertical: 20),
                    //   child: BaseButton( 
                    //     width: double.infinity,
                    //     text: 'Cập nhật',
                    //     onTap: () {
                    //       if (key.currentState!.validate()) {
                    //        infoUserModel.staff!.fullName = controllerName.text;
                    //        infoUserModel.staff!.phone = controllerPhone.text;
                    //        infoUserModel.staff!.mail = controllerEmail.text;
                    //        infoUserModel.staff!.fullAddress = controllerAddress.text;
                    //         accountCubit.updateUserInfo(infoUserModel);
                    //       }
                    //     },
                    //   ),
                    // )
                  },
                ],
              ),
            )),
          ),
        ));
  }
}
