import 'package:dio/dio.dart';

import '../service/api.dart';

class AddressRepository {
  Dio dio = Dio();
  Future<Response> listCity() async {
    return await dio.get(Api.convertURL(Api.apiListCity), queryParameters: {"PageSize": 63});
  }

  Future<Response> listDistrist(int id) async {
    return await dio.get(Api.convertURL(Api.apiListDistrist), queryParameters: {"PageSize": 100, "IdCity": id});
  }

  Future<Response> listWard(int id) async {
    return await dio.get(Api.convertURL(Api.apiListWard), queryParameters: {"PageSize": 100, "IdDistrict": id});
  }

  Future<Response> listStation(String name)async {
    // return await dio.get(Api.convertURL(Api.apiListStation), queryParameters: {"IdCity": id ?? 0});
  return await dio.get(Api.convertURL(Api.apiListStation), queryParameters: {"Name": name});
  }
  Future<Response> listStationAll(String name)async {
    // return await dio.get(Api.convertURL(Api.apiListStation), queryParameters: {"IdCity": id ?? 0});
  return await dio.get(Api.convertURL(Api.apiListStation));
  }

  Future<Response> listCityAll() async {
    return await dio.get(Api.convertURL(Api.apiListCityAll));
  }
}
