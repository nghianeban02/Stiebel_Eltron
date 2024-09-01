import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_state.dart';
import 'package:stiebel_etron_warranty/storage/fake_data.dart';

import '../../main.dart';
import '../../model/customer_model.dart';
import '../../model/form_activate_model.dart';
import '../../model/list_active_model.dart';
import '../../model/search_active_model.dart';
import '../../model/select_product_model.dart';
import '../../model/serial_active_model.dart';
import '../../navigator/app_router.dart';
import '../../repository/activate_repository.dart';
import '../../repository/product_repository.dart';
import '../../screen/widget/custom_common.dart';
import '../../screen/widget/custom_error.dart';
import '../../service/api.dart';

class ActivateCubit extends Cubit<ActivateState> {
  ActivateCubit() : super(ActivateInitial());
  ActiveModel formActivate = ActiveModel();
  Customer customer = Customer();
  ActiveModel formActivateNotToken = ActiveModel();
  Customer customerNoteToken = Customer();
  ActivateRepository activateRepository = ActivateRepository();
  SerialActiveModel serialActiveModel = SerialActiveModel();
  SearchActiveModel searchActiveModel = SearchActiveModel();
  List<ListDataActive> listActivate = [];
  List<ListDataActive> listActivateSearch = [];
  int pageIndex = 0;
  int totalPage = 0;
  int totalPriceActive = 0;
  int totalPointActive = 0;
  ProductRepository productRepository = ProductRepository();
  List<SelectProductModel> listCategory = [];
  List<SelectProductModel> listModel = [];
  XFile? selectImage;
  resetform() {
    formActivate = ActiveModel();
    customer = Customer();
    selectImage = null;
    formActivateNotToken = ActiveModel();
    customerNoteToken = Customer();
    serialActiveModel = SerialActiveModel();
  }

  updateFormProduct(
      {String? code,
      String? serial,
      int? modelId,
      String? dayBuy,
      Customer? customer,
      String? image1,
      String? image2}) async {
    formActivate = formActivate.copyWith(
      code: code,
      serial: serial,
      dayBuy: dayBuy,
      customer: customer,
      modelId: modelId,
      image1: image1,
      image2: image2,
    );
  }

  updateFormCustomer({
    String? fullName,
    String? phone,
    String? mail,
    int? cityId,
    int? districtId,
    int? wardId,
    String? street,
    String? wardName,
    String? districtName,
    String? cityName,
    String? addressFull,
  }) async {
    customer = customer.copyWith(
      fullName: fullName,
      phone1: phone,
      cityId: cityId,
      cityName: cityName,
      districtId: districtId,
      districtName: districtName,
      wardId: wardId,
      wardName: wardName,
      street: street,
      addressFull: addressFull,
    );
    formActivate = formActivate.copyWith(
      phoneActive: phone,
    );
  }

  // updateFormProductNoteToken({
  //   String? code,
  //   String? serial,
  //   int? modelId,
  //   String? dayBuy,
  //   Customer? customer,
  // }) async {
  //   formActivateNotToken = formActivateNotToken.copyWith(
  //     code: code,
  //     serial: serial,
  //     dayBuy: dayBuy,
  //     customer: customer,
  //     modelId: modelId,
  //   );
  // }

  // updateFormCustomerNotToken(
  //     {String? fullName,
  //     String? phone,
  //     int? cityId,
  //     int? districtId,
  //     int? wardId,
  //     String? street,
  //     String? wardName,
  //     String? districtName,
  //     String? cityName,
  //     String? image,
  //     String? addressFull}) async {
  //   customerNoteToken = customerNoteToken.copyWith(
  //       fullName: fullName,
  //       phone1: phone,
  //       cityId: cityId,
  //       cityName: cityName,
  //       districtId: districtId,
  //       districtName: districtName,
  //       wardId: wardId,
  //       wardName: wardName,

  //       addressFull: addressFull,
  //       street: street);
  //   formActivateNotToken = formActivateNotToken.copyWith(
  //     phoneActive: phone,
  //     image: image,
  //   );
  // }

  Future getListCategory() async {
    var res = await productRepository.listCategory();
    if (res != null && res != '' && res.data != null) {
      listCategory = (res.data as List)
          .map((e) => SelectProductModel.fromJson(e))
          .toList();

      emit(GetCategorySuccess(list: listCategory));
    }
  }

  Future getListModel(int id) async {
    var res = await productRepository.listModel(id);

    if (res != null && res != '' && res.data != null) {
      listModel = (res.data['listData'] as List)
          .map((e) => SelectProductModel.fromJson(e['data']))
          .toList();

      emit(GetModelSuccess(list: listModel));
    }
  }

  Future getListActivate(
      {int? indexPage,
      String? phone,
      String? serial,
      String? toDate,
      String? fromDate}) async {
    try {
      //  listActivate =
      // (jsonActive['listData'] as List).map((e) => ListDataActive.fromJson(e)).toList();

      emit(GetListActivateLoading(isLoading: true));
      var res = await activateRepository.getListActivate(
          pageIndex: indexPage,
          fromDate: fromDate,
          toDate: toDate,
          phone: phone,
          serial: serial);
      if (res != null && res != '' && res.data != null) {
        listActivate = (res.data['listData'] as List)
            .map((e) => ListDataActive.fromJson(e))
            .toList();
        totalPage = res.data['totalPages'];
        pageIndex = res.data['pageIndex'];
        int totalActive = res.data['totalData'];
        // var resSum = await activateRepository.sum(fromDate, toDate);
        // if (resSum != null && resSum != '' && resSum.data != null) {
        //   totalPointActive = resSum.data['totalPointActive'];
        //   totalPriceActive = resSum.data['totalPriceActive'];
        // }
        emit(GetListActivateLoading(isLoading: false));
        emit(GetListActivateSuccess(
            list: listActivate,
            totalPage: totalPage,
            pageIndex: pageIndex,
            totalActive: totalActive,
            totalPointActive: totalPointActive,
            totalPriceActive: totalPriceActive));
      }
    } on DioError catch (e) {
      emit(GetListActivateLoading(isLoading: false));
      CustomDioError.errorDio(e);
    }
  }

  Future sum({String? fromDate, String? toDate}) async {
    try {
      emit(GetListActivateLoading(isLoading: true));
    } catch (e) {
      print(e);
      emit(GetListActivateLoading(isLoading: false));
    }
  }

  Future uploadImage() async {
    if (selectImage != null) {
      var res = await activateRepository.uploadImage(File(selectImage!.path));
      if (res != null && res.statusCode == 200) {
        updateFormProduct(
            image1: Api.baseApi +
                'file-management/' +
                res.data['pathOriginal'].toString(),
            image2: Api.baseApi +
                'file-management/' +
                res.data['pathOriginal'].toString());
        print(Api.baseApi +
            'file-management/' +
            res.data['pathOriginal'].toString());
      }
    }
  }

  // Future getActiveBySerial(String serial) async {
  //   try {
  //     var res = await activateRepository.getActiveBySerial(serial);
  //     if (res != null && res.data != null) {
  //       searchActiveModel = SearchActiveModel.fromJson(res.data);
  //       emit(GetSearchActive(
  //          modelId: searchActiveModel.modelId??0,
  //           modelName: searchActiveModel.modelName??'',
  //           categoryCode: searchActiveModel.categoryCode??'',
  //           categoryId: searchActiveModel.categoryId??0,
  //           categoryName: searchActiveModel.categoryName??'',
  //           statusActive: searchActiveModel.statusActive??0,
  //           )
  //           );
  //     } else {
  //       Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Serial không tồn tại');
  //       emit(GetSearchActive(
  //           modelId: 0, modelName: '', categoryCode: '', categoryId: 0, categoryName: "",statusActive: 0));
  //     }
  //   } on DioError catch (e) {
  //     Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Serial không tồn tại');
  //   }
  // }

  Future addActivate() async {
    try {
      emit(AddActivateLoading(isLoading: true));
      uploadImage();
      if (formActivate.dayBuy == null)
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!,
            'Vui lòng chọn ngày mua');

      if (customer.cityId != null ||
          customer.districtId != null ||
          customer.wardId != null) {
        updateFormCustomer(
            addressFull:
                ' ${customer.street!}, ${customer.wardName!}, ${customer.districtName!}, ${customer.cityName!}');
        updateFormProduct(customer: customer);

        if (formActivate.modelId != null && formActivate.modelId != 0) {
          print(formActivate.toJson());
          var res = await activateRepository.addActivate(formActivate);

          if (res != null && res.statusCode == 200) {
            Navigator.pushNamedAndRemoveUntil(
                NavigateKeys().navigationKey.currentContext!,
                AppRouter.homePage,
                (route) => false);
            resetform();
            Common.showSnackBar(NavigateKeys().navigationKey.currentContext!,
                'Kích hoạt thành công');
            emit(AddActivateLoading(isLoading: false));
          }
        } else {
          emit(AddActivateLoading(isLoading: false));
          Common.showSnackBar(NavigateKeys().navigationKey.currentContext!,
              'Vui lòng chọn sản phẩm');
        }
      } else {
        emit(AddActivateLoading(isLoading: false));
        Common.showSnackBar(NavigateKeys().navigationKey.currentContext!,
            'Vui lòng chọn địa chỉ');
      }
      emit(AddActivateLoading(isLoading: false));
    } on DioError catch (e) {
      emit(AddActivateLoading(isLoading: false));
      print(e.toString());
      CustomDioError.errorDio(e);
    }
  }

  // Future addActivateNotToken() async {
  //   try {
  //     emit(AddActivateLoading(isLoading: true));

  //     print(customerNoteToken.cityId);
  //     if (formActivateNotToken.dayBuy == null) Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn ngày mua');
  //     if (customerNoteToken.cityId != null || customerNoteToken.districtId != null || customerNoteToken.wardId != null) {
  //       updateFormCustomerNotToken(addressFull: '${customerNoteToken.street!}, ${customerNoteToken.wardName}, ${customerNoteToken.districtName!}, ${customerNoteToken.cityName!}');

  //       updateFormProductNoteToken(customer: customerNoteToken);
  //       if (formActivateNotToken.modelId != null) {
  //         var res = await activateRepository.addActivateNotToken(formActivateNotToken);
  //         if (res != null && res.statusCode == 200) {
  //           Navigator.push(NavigateKeys().navigationKey.currentContext!, MaterialPageRoute(builder: (context) => ConfirmOtp(typeOTP: Type,)));

  //           emit(AddActivateLoading(isLoading: false));
  //         }
  //       } else {
  //         emit(AddActivateLoading(isLoading: false));
  //         Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn sản phẩm');
  //       }
  //     } else {
  //       emit(AddActivateLoading(isLoading: false));
  //       Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Vui lòng chọn địa chỉ');
  //     }
  //     emit(AddActivateLoading(isLoading: false));
  //   } catch (e) {
  //     print(e);
  //     emit(AddActivateLoading(isLoading: false));
  //     Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, 'Sai thông tin kích hoạt');
  //   }
  // }

  // Future getListActivatePhoneNumber({String? phoneNumber, int? indexPage}) async {
  //   listActivateSearch = (fakeData['listData'] as List).map((e) => ListDataActive.fromJson(e)).toList();
  // }
}
