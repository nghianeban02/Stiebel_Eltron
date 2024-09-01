import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:string_normalizer/string_normalizer.dart';
import '../../model/address_model.dart';
import '../../model/station_model.dart';
import '../../repository/address_repository.dart';
import 'warranty_station_state.dart';

class WarrantyStationCubit extends Cubit<WarrantyStationState> {
  WarrantyStationCubit() : super(WarrantyStationInitial());
  AddressRepository addressRepository = AddressRepository();
  List<ListDataAddress> addressModelCity = [];

  late String selectedProvince = '';

  List<StationModel> listStation = [];
  Future getListCity({String? search}) async {
    var res = await addressRepository.listCity();
    if (res != null && res != '' && res.data != null) {
      addressModelCity = (res.data['listData'] as List)
          .map((e) => ListDataAddress.fromJson(e))
          .toList();
      if (search != null && search != '' && addressModelCity.isNotEmpty) {
        addressModelCity = addressModelCity
            .where((element) => element.name!
                .normalize()
                .toLowerCase()
                .contains(search.normalize().toLowerCase()))
            .toList();
      }
    }
    return addressModelCity;
  }

  Future getListStation(String name) async {
    switch (name) {
      case 'Hồ Chí Minh':
        name = 'CÔNG TY TNHH STIEBEL ELTRON VIỆT NAM';
        break;
      case 'Đắk Nông':
        name = 'DakNong';
        break;
      case 'Đắk Lắk':
        name = 'DakLak';
        break;
      case 'Bà Rịa - Vũng Tàu':
        name = 'Bà Rịa Vũng Tàu';
        break;
      case 'Bắc Kạn':
        name = 'Bác Kạn';
        break;
      case 'Hoà Bình':
        name = 'Hòa Bình';
        break;  
      default:
        // Giữ nguyên giá trị của name nếu không khớp với bất kỳ case nào
        break;
    }
    emit(StationLoading(true));
    var res = await addressRepository.listStation(name);
    print(res.data);
    if (res != null && res != '' && res.data != null) {
      listStation =
          (res.data as List).map((e) => StationModel.fromJson(e)).toList();

      emit(StationSuccess(
          selectedProvince: selectedProvince, listStation: listStation));
    }

    emit(StationLoading(false));
    return listStation;
  }

  void updateSelectedProvince(String province) {
    selectedProvince = province;
    getListStation(province);
  }

  // void fetchStations(String province) {
  //   emit(StationSuccess(selectedProvince: selectedProvince, listStation: listStation));
  // }
}
