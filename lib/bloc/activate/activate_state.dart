import 'package:stiebel_etron_warranty/model/list_active_model.dart';
import 'package:stiebel_etron_warranty/model/select_product_model.dart';
import 'package:meta/meta.dart';


@immutable
abstract class ActivateState {}

class ActivateInitial extends ActivateState {}

class GetCategorySuccess extends ActivateState {
  final List<SelectProductModel> list;
  GetCategorySuccess({required this.list});
}

class GetModelSuccess extends ActivateState {
  final List<SelectProductModel> list;
  GetModelSuccess({required this.list});
}

class GetListActivateSuccess extends ActivateState {
  final List<ListDataActive> list;
  final int totalPage;
  final int pageIndex;
  final int totalActive;
  final int totalPriceActive;
  final int totalPointActive;
  GetListActivateSuccess(
      {required this.list,
      required this.totalPage,
      required this.pageIndex,
      required this.totalActive,
      required this.totalPointActive,
      required this.totalPriceActive});
}

class GetListActivateLoading extends ActivateState {
  final bool isLoading;
  GetListActivateLoading({this.isLoading = false});
}

class GetSearchActive extends ActivateState {
  final int modelId;
  final String modelName;
  final int categoryId;
  final String categoryCode;
  final String categoryName;
  final int statusActive;
  GetSearchActive({required this.modelId, required this.modelName, required this.categoryCode, required this.categoryId, required this.categoryName,required this.statusActive});
}

class AddActivateLoading extends ActivateState {
  final bool isLoading;
  AddActivateLoading({this.isLoading = false});
}

class AddActivateSuccess extends ActivateState {
  AddActivateSuccess();
}
