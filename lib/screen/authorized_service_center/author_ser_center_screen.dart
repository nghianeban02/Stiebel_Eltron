import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/bloc/warranty_station/warranty_station_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/warranty_station/warranty_station_state.dart';
import 'package:stiebel_etron_warranty/model/station_model.dart';
import 'package:stiebel_etron_warranty/service/launch_url.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../widget/authorSerCenter/service_center_form_list.dart';
import '../widget/custom_text.dart';

class AuthorServiceCenterScreen extends StatefulWidget {
  const AuthorServiceCenterScreen({super.key});

  @override
  _AuthorServiceCenterScreenState createState() => _AuthorServiceCenterScreenState();
}

class _AuthorServiceCenterScreenState extends State<AuthorServiceCenterScreen> {
  late WarrantyStationCubit warrantyStationCubit;
  final textConntroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    warrantyStationCubit = BlocProvider.of<WarrantyStationCubit>(context)..getListCity();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   FocusManager.instance.primaryFocus!.unfocus();
      // },
      child: Scaffold(
        backgroundColor: AppColors.backgroudWhite,
        appBar: AppBar(
          title: Text(
            LocaleKeys.listStation.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.backgroudWhite,
          foregroundColor: AppColors.textRed,
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: ServiceCenterForm(),
              ),

              Expanded(
                child: BlocBuilder<WarrantyStationCubit, WarrantyStationState>(
                  buildWhen: (previous, current) =>
                      current is StationSuccess || previous is StationLoading,
                  builder: (context, state) {
                    if (state is StationSuccess) {
                      return state.listStation.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.listStation.length,
                              itemBuilder: (context, index) {
                                return itemlist(state.listStation[index]);
                              })
                          : Text(LocaleKeys.noCenter.tr);
                    }
                    if (state is StationLoading && state.isLoading) {
                      return Loader();
                    }
                    return const SizedBox();
                  },
                ),
              )
              //   TypeAheadField(
              //   suggestionsBoxDecoration: const SuggestionsBoxDecoration(),
              //   textFieldConfiguration: TextFieldConfiguration(
              //   controller: textConntroller,
              //       //autofocus: true,
              //       // style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
              //       decoration: InputDecoration(hintText:LocaleKeys.lookFor.tr, border: const OutlineInputBorder())),
              //       suggestionsCallback: (pattern) async {
              //     return await warrantyStationCubit.getListCity(search: pattern);
              //   },
              //   itemBuilder: (context, suggestion) {
              //     return CustomText().textSize18(title: (suggestion as ListDataAddress).name).paddingSymmetric(horizontal: 10, vertical: 10);
              //   },
              //   onSuggestionSelected: (suggestion) async {
              //     print((suggestion as ListDataAddress).name);
              //     textConntroller.text = suggestion.name ?? '';
              //     await warrantyStationCubit.getListStation(id: (suggestion.id??0).toString());
              //   },
              // // ).paddingAll(16),
              // Expanded(
              //   child: BlocBuilder<WarrantyStationCubit, WarrantyStationState>(
              //     buildWhen: (previous, current) => current is StationSuccess,
              //     builder: (context, state) {
              //       print('Number of stations: ${warrantyStationCubit.listStation.length}');
              //       return warrantyStationCubit.listStation.isNotEmpty
              //           ? ListView.builder(
              //               itemCount: warrantyStationCubit.listStation.length,
              //               itemBuilder: (context, index) {
              //                 return itemlist(warrantyStationCubit.listStation[index]);
              //               })
              //           : Loader();
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

itemlist(StationModel stationModel) {
  return Center(
    child: Container(
      alignment: Alignment.center,
      margin:const EdgeInsets.symmetric(horizontal: 16), // Thêm khoảng trống cách 2 bên lề
      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white.withOpacity(1.0),
          border: Border.all(color: AppColors.primary.withOpacity(1.0), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText().textSize18(title: stationModel.name),
          callPhone(stationModel.phone ?? ''),
          address(stationModel)
        ],
      ),
    ).paddingTop(6),
  );
}

callPhone(String text) {
  List listPhone = text.contains('/') ? text.split('/') : text.split(',');
  print(listPhone);
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.phone,
            size: 15,
            color: AppColors.grey,
          ),
          for (int i = 0; i < listPhone.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText().textSize14(text: listPhone[i]).withWidth(120).onTap(() {
                  CustomURL().launchCaller(listPhone[i]);
                })
              ],
            ),
        ],
      ).paddingSymmetric(vertical: 5).paddingRight(10));
}

address(StationModel stationModel) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.location_city,
        size: 15,
        color: AppColors.grey,
      ),
      Expanded(child: CustomText().textSize14(text: stationModel.addressFull)),
    ],
  ).paddingSymmetric(vertical: 5).onTap(() {
    MapsLauncher.launchQuery(stationModel.addressFull ?? '');
  });
}
