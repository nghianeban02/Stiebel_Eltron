import 'package:meta/meta.dart';
import 'package:stiebel_etron_warranty/model/station_model.dart';
import '../../model/address_model.dart';

@immutable
abstract class WarrantyStationState {}

class WarrantyStationInitial extends WarrantyStationState {}

class SearchCitySuccess extends WarrantyStationState {
  SearchCitySuccess();
}

class StationSuccess extends WarrantyStationState {
  final String selectedProvince;
  final List<StationModel> listStation;
  StationSuccess({required this.selectedProvince, required this.listStation});
}

class StationLoading extends WarrantyStationState {
  final bool isLoading;
  StationLoading(this.isLoading);
}

class CitySuccess extends WarrantyStationState {
  final List<ListDataAddress> listCity;
  CitySuccess({required this.listCity});
}
