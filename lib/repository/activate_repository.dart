import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import '../model/form_activate_model.dart';
import '../service/api.dart';
import '../storage/app_preferences.dart';
import 'account_repository.dart';

class ActivateRepository {
  Dio dio = Dio();
  Future<Response> addActivate(ActiveModel activeModel) async {
    print(jsonEncode(activeModel));
    print(Api.convertURL(Api.apiAddActivate));
    return await dio.post(Api.convertURL(Api.apiAddActivate), options: await AccountReposipory().options(isUseToken: true), data: jsonEncode(activeModel));
  }

  Future<Response> getActiveBySerial(String serial) async {
    return await dio.get(
      Api.convertURL(Api.apiActiveDataBySerial.replaceAll('{serial}', serial)),
    options: await AccountReposipory().options(isUseToken: true),
    );
  }

  Future<Response> addActivateNotToken(ActiveModel activeModel) async {
    print(jsonEncode(activeModel));
    return await dio.post(Api.convertURL(Api.apiAddActivateNotToken), data: jsonEncode(activeModel));
  }

  Future<Response> getListActivate({int? pageIndex, String? phone, String? serial, String? toDate, String? fromDate}) async {
    return await dio.get(Api.convertURL(Api.apiListActivate),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'text/plain',
          'Authorization': 'Bearer ${AppPreferencesImpl().getToken.toString()}',
        }),
        queryParameters: { 'PageIndex': pageIndex ?? 1, 'KeySearch': phone, 'Serial': serial,'FromDate': fromDate, 'ToDate': toDate});
  }

  Future<Response> sum(String? fromDate, String? toDate) async {
    return await dio.get(Api.convertURL(Api.apiSum),
        options: Options(headers: {'Content-Type': 'application/json', 'Accept': 'text/plain', 'Authorization': 'Bearer ${AppPreferencesImpl().getToken.toString()}'}),
        queryParameters: {'FromDate': fromDate ?? '', "ToDate": toDate ?? ''});
  }

  Future<Response> uploadImage(File file) async {
    print(Api.convertURL(Api.apiUploadImage));
    FormData body = FormData.fromMap({'Image': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "jpeg")), 'GroupImage': "SANPHAM"});
    return await dio.post(Api.convertURL(Api.apiUploadImage), options: await options(isUseToken: true), data: body);
  }

  Future<Options> options(
      {bool isNotUsedContentType = true,
      String? hashCode,
      String? tokenProtected,
      bool isUseToken = false,
      bool isNotContentType = false,
      Map<String, dynamic>? header,
      String enctype = ''}) async {
    var token = AppPreferencesImpl().getToken.toString();
    var options = Options(
      headers: {
        'Accept': 'application/json',
      },
    );

    if (header != null) {
      header.forEach((key, value) {
        options.headers![key] = value;
      });
    }
    if (!Utils.isNullOrEmpty(enctype)) {
      options.headers!['enctype'] = enctype;
    }
    if (hashCode != null) {
      options.headers!['hash'] = hashCode;
    }
    if (tokenProtected != null) {
      options.headers!['protected_token'] = tokenProtected;
    }

    if (isNotContentType) {
      if (isNotUsedContentType) {
        options.contentType = 'application/json';
      } else {
        options.contentType = "application/x-www-form-urlencoded";
      }
    }
    try {
      if (token.isNotEmpty && isUseToken) {
        options.headers!['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print(e);
    }
    return options;
  }
}
