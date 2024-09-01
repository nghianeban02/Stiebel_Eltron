import 'package:dio/dio.dart';
import '../../config/utils.dart';
import '../../main.dart';
import 'custom_common.dart';

class CustomDioError {
  static errorDio(DioError e) async {
    if(!(e.response?.data is String)){ if ( !Utils.isNullOrEmpty(e.response!.data['errors'])) {
      var list = await e.response!.data['errors'];

      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, (list as Map).values.toList()[0][0].toString());
    } else if (!Utils.isNullOrEmpty(e.response!.data['description'])) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['description'][0].toString());
    } else if (!Utils.isNullOrEmpty(e.response!.data['detail']) && e.response!.data['detail'].toString().contains('_') == false) {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['detail'].toString());
    } else {
      Common.showSnackBar(NavigateKeys().navigationKey.currentContext!, e.response!.data['title'].toString());
    }
  }}
   
}
