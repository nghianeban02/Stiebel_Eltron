import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../../config/utils.dart';
import '../../main.dart';
import '../../model/info_user_model.dart';
import '../../model/register_model.dart';
import '../../navigator/app_router.dart';
import '../../repository/account_repository.dart';
import '../../screen/widget/custom_common.dart';
import '../../screen/widget/custom_error.dart';
import '../../service/enum.dart';
import '../../storage/app_preferences.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  AccountReposipory accountReposipory = AccountReposipory();
  InfoUserModel infoUserModel = InfoUserModel();
  RegisterModel registerModel = RegisterModel();
  RegisterModel registerCustomer = RegisterModel();
  AppPreferencesImpl appPreferencesImpl = AppPreferencesImpl();
  Future login({String password = '', String phoneNumber = ''}) async {
    try {
      emit(LoginLoading(isLoading: true));
      var res = await accountReposipory.login(phoneNumber, password);
      if (res != null && res.data is String) {
        appPreferencesImpl.setToken(res.data);
        appPreferencesImpl.setAccount(phoneNumber);
        appPreferencesImpl.setPassword(password);

        Navigator.pushNamedAndRemoveUntil(
            NavigateKeys().navigationKey.currentContext!, AppRouter.homePage, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, LocaleKeys.loginSuccess.tr);
        emit(LoginLoading(isLoading: false));
      }
    } on DioError catch (e) {
      emit(LoginLoading(isLoading: false));
      CustomDioError.errorDio(e);
    }
  }
  Future setStatus(String token) async {
    try {
      var res = await accountReposipory.setStatus(token);
      if (res != null && res.statusCode == 200) {
        appPreferencesImpl.setToken(null);
        appPreferencesImpl.setAccount(null);
        appPreferencesImpl.setPassword(null);
        Navigator.pushNamedAndRemoveUntil(
        NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        // Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, LocaleKeys.logoutSuccess.tr);
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }
  Future changePassword(String oldPass, String newPass) async {
    try {
      var res = await accountReposipory.changePassword(oldPass, newPass);

      if (res != null && res.data != null) {
        Navigator.pop(NavigateKeys().navigationKey.currentContext!);
        // Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!, AppRouter.homePage, (route) => false);
        AppPreferencesImpl().setPassword(newPass);
        Common.showSnackBar(
            NavigateKeys().navigationKey.currentContext!,LocaleKeys.changePassSuccess.tr);
      }
    } on DioError catch (e) {
      print(e);
      Common.showSnackBar(
          NavigateKeys().navigationKey.currentContext!,LocaleKeys.changePassFail.tr);
    }
  }
  // Future updateUserInfo(InfoUserModel infoUserModel) async {
  //   try {
  //     var res = await accountReposipory.updateInfo(infoUserModel, infoUserModel.staff!.id.toString());
  //     if (res != null && res.statusCode == 200) {
  //       Common.showSnackBar(
  //           NavigateKeys().navigationKey.currentContext!, 'Cập nhật thông tin thành công');
  //     }
  //     else{
  //       Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Cập nhật thông tin thất bại');
  //     }
  //   } on DioError catch (e) {
  //     CustomDioError.errorDio(e);
  //   }
  // }

  // Future sendOpt(String phone, TypeOTP typeOTP, {String? password, String? name}) async {
  //   try {
  //     var res = await accountReposipory.sendOtp(phone);
  //     if (res != null && res.statusCode == 200) {
  //       Navigator.push(
  //           NavigateKeys().navigationKey.currentContext!,
  //           MaterialPageRoute(
  //               builder: (context) => ConfirmOtp(
  //                     typeOTP: typeOTP,
  //                     phone: phone,
  //                     password: password ?? '',
  //                     name: name ?? "",
  //                   )));
  //     }
  //   } on DioError catch (e) {
  //     Common.showSnackBar(
  //         NavigateKeys().navigationKey.currentContext!, 'Số điện thoại không hợp lệ');
  //   }
  // }

  Future checkOtp(String phone, String code) async {
    try {
      var res = await accountReposipory.checkOtp(phone, code);
      if (res != null && res.statusCode == 200) {
        await register();
      }
    } on DioError catch (e) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Mã OTP không đúng');
    }
  }
      //update userinfo
//   Future<bool> updateUserInfo(InfoUserModel infoUserModel) async {
//   try {
//     // Gọi hàm updateInfo với các thông tin từ infoUserModel
//     var res = await accountReposipory.updateInfo(
//       infoUserModel.fullname,
      
//     );

//     // Kiểm tra kết quả trả về
//     if (res != null && res.statusCode == 200) {
//       return true; // Cập nhật thành công
//     }
//   } on DioError catch (e) {
//     CustomDioError.errorDio(e); // Xử lý lỗi
//   }
//   return false; // Cập nhật thất bại
// }

  Future checkOtpCustomer(
    String password,
    String phone,
    String code,
    String name,
  ) async {
    try {
      var res = await accountReposipory.checkOtp(phone, code);
      if (res != null && res.statusCode == 200) {
        await registerKhachLe(phone, name, password);
        //  await registerKhachLe(phone, name, password);
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }
  
  // Future checkOtpFogetPassword(
  //   String password,
  //   String phone,
  //   String code,
  // ) async {
  //   try {
  //     var res = await accountReposipory.checkOtp(phone, code);
  //     if (res != null && res.statusCode == 200) {
  //       await fogetPassword(password, phone);
  //     }
  //   } on DioError catch (e) {
  //     print(e);
  //     Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Mã OTP không đúng');
  //   }
  // }
  
  Future getUserInfo() async {
    try {
      var resUser = await accountReposipory.infoUser();

      if (resUser != null && resUser.data != null) {
        infoUserModel = InfoUserModel.fromJson(resUser.data);
        AppPreferencesImpl().setDoiTac(infoUserModel.idGroupUser);
      }
      emit(GetUserSuccess(infoUserModel: infoUserModel));
    } on DioError catch (e) {
      print(e);
      Navigator.pushNamedAndRemoveUntil(
          NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
      Common.showSnackBar(
          NavigateKeys().navigationKey.currentContext!, 'Tài khoản hết hiệu lực');
    }
  }
  // Future deleteAccount(BuildContext context) async {
  //   try {
  //     var resUser = await accountReposipory.getInfo(infoUserModel.account ?? '');
  //     if (resUser.statusCode == 200) {
  //       var resUpdate = await accountReposipory.updateStatusInfo(
  //           infoUserModel.account ?? '', resUser.data['updateDate']);
  //       if (resUpdate.statusCode == 200) {
  //         Navigator.pop(context);
  //         Navigator.pushNamedAndRemoveUntil(NavigateKeys().navigationKey.currentContext!,
  //             AppRouter.loginScreen, (route) => false);
  //         AppPreferencesImpl().setToken(null);
  //         Get.showSnackbar(const GetSnackBar(
  //           backgroundColor: AppColors.backgroudColor,
  //           duration: Duration(seconds: 3),
  //           messageText: Text('Xóa tài khoản thành công'),
  //         ));
  //       } else {
  //         Get.showSnackbar(const GetSnackBar(
  //           backgroundColor: AppColors.backgroudColor,
  //           duration: Duration(seconds: 3),
  //           messageText: Text('Vui lòng thử lại sau'),
  //         ));
  //       }
  //     } else {
  //       Get.showSnackbar(const GetSnackBar(
  //         backgroundColor: AppColors.backgroudColor,
  //         duration: Duration(seconds: 3),
  //         messageText: Text('Vui lòng thử lại sau'),
  //       ));
  //     }
  //   } on DioError catch (e) {
  //     CustomDioError.errorDio(e);
  //   }
  // }

  Future register() async {
    try {
      updateFormRegister(
          acceptDate: Utils().convertDateToString(DateTime.now()),
          code: registerModel.phone,
          noteActive: '');
      var res = await accountReposipory.register(registerModel);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(
            NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đăng kí thành công');
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future registerKhachLe(String phone, String name, String password) async {
    try {
      updateFormRegister(
          acceptDate: Utils().convertDateToString(DateTime.now()),
          code: registerModel.phone,
          noteActive: '');
      var res = await accountReposipory.registerKhachLe(phone, name, password);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(
            NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Đăng kí thành công');
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future fogetPassword(String email) async {
    try {
      var res = await accountReposipory.fogetPassword(email);
      if (res != null && res.data is String) {
        Navigator.pushNamedAndRemoveUntil(
            NavigateKeys().navigationKey.currentContext!, AppRouter.loginScreen, (route) => false);
        Common.showSnackBar(
          NavigateKeys().navigationKey.currentContext!,LocaleKeys.checkYourEmailToReset.tr);
      }
    } on DioError catch (e) {
      CustomDioError.errorDio(e);
    }
  }

  Future updateFormCustomer(
      {String? code, String? fullName, String? mail, String? phone, String? password}) async {
    registerCustomer = registerCustomer.copyWith(
        code: code, fullName: fullName, mail: mail, phone: phone, password: password);
  }

  Future updateFormRegister({
    String? idPartnerType = '1',
    String? code,
    String? fullName,
    String? mail,
    String? phone,
    String? street,
    String? noIdentity,
    String? taxCode,
    String? password,
    int? idCity,
    int? idDistrict,
    int? idWard,
    String? fullAddress,
    String? noteActive,
    String? acceptDate,
    String? bankName,
    String? bankAccountName,
    String? bankAccountNumber,
  }) async {
    registerModel = registerModel.copyWith(
        idPartnerType: idPartnerType,
        code: code,
        fullName: fullName,
        mail: mail,
        phone: phone,
        street: street,
        taxCode: taxCode,
        noIdentity: noIdentity,
        idCity: idCity,
        idDistrict: idDistrict,
        idWard: idWard,
        password: password,
        fullAddress: fullAddress,
        noteActive: noteActive,
        acceptDate: acceptDate,
        bankName: bankName,
        bankAccountName: bankAccountName,
        bankAccountNumber: bankAccountNumber);
  }
}
