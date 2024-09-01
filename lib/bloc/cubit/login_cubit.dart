import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stiebel_etron_warranty/model/user_model.dart';
import 'package:stiebel_etron_warranty/repository/account_repository.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  AppPreferencesImpl appPreferencesImpl = AppPreferencesImpl();
  AccountReposipory accountReposipory = AccountReposipory();

  UserModel us = UserModel();
  Future<void> login(String phoneNumber, String password) async {
    try {
      emit(LoginLoading(isLoading: true));
      var res = await accountReposipory.login(phoneNumber, password);
      if (res != null && res.data is String) {
        appPreferencesImpl.setToken(res.data);
        emit(LoginLoading(isLoading: false));
        emit(LoginSuccess());
      }
    } on DioException catch (e) {
      emit(LoginLoading(isLoading: false));
      if (e.response?.statusCode == 401) {
        emit(LoginError(message: 'Sai tài khoản hoặc mật khẩu'));
      } else {
        emit(LoginError(message: 'Đã có lỗi xảy ra'));
      }
    }
  }
  Future getInfo() async {
    var res = await accountReposipory.infoUser();
    if (res != null) {
      us = UserModel.fromJson(res.data);
      emit(GetInfoSuccess(user_model: us));
      print(us.toJson());
    }
  }
  // Future updateInfo()async{
  //   var res = await accountReposipory.updateInfo(us);
  // }

}
