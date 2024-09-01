import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_state.dart';
import 'package:stiebel_etron_warranty/config/color.dart';
import 'package:stiebel_etron_warranty/model/list_active_model.dart';
import 'package:stiebel_etron_warranty/screen/widget/activationStatistic/boder_list_activation.dart';
import 'package:stiebel_etron_warranty/screen/widget/activationStatistic/phone_tabbar.dart';
import 'package:stiebel_etron_warranty/screen/widget/activationStatistic/serial_tabbar.dart';
import 'package:stiebel_etron_warranty/service/enum.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import '../../bloc/cores/cores_bloc_cubit.dart';
import '../widget/custom_tabbar.dart';

class ActivationStatistic extends StatefulWidget {
  const ActivationStatistic({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivationStatisticState createState() => _ActivationStatisticState();
}

class _ActivationStatisticState extends State<ActivationStatistic> {
  int index = 0;
  DateTime selectedDate = DateTime.now().add(Duration(days: 0));
  var searchHistory = SearchHistory.phone.obs;
  bool checkList = true;
  late ActivateCubit activateCubit;
  int totalPage = 0;
  int pageIndex = 0;
  int totalActive = 0;
  int totalPriceActive = 0;
  int totalPointActive = 0;
  List<ListDataActive> listActivate = [];
  String result = "";
  bool DOITAC = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    activateCubit = BlocProvider.of<ActivateCubit>(context)..getListActivate();
    DOITAC = AppPreferencesImpl().getDoiTac == 'DOITAC';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudWhite,
      appBar: AppBar(
        title: Text(
          LocaleKeys.activateStatistics.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.searchBy.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            child: BlocBuilder<CoresBlocCubit, CoresBlocState>(
              builder: (context, state) {
                if (state is CoresOnchangeTabRegister) {
                  index = state.index;
                }
                return CustomRadioTabBar(
                  tabs: [LocaleKeys.phoneNumber.tr, LocaleKeys.serial.tr],
                  selectedIndex: index,
                  onChanged: (newIndex) {
                    context
                        .read<CoresBlocCubit>()
                        .onChangeTabRegister(newIndex);
                  },
                );
              },
            ),
          ),
          BlocBuilder<CoresBlocCubit, CoresBlocState>(
            builder: (context, state) {
              if (state is CoresOnchangeTabRegister) {
                index = state.index;
              }
              return index == 0 ? TabBarPhone() : TabBarSerial();
            },
          ),
          //ListStatistic(),
          // backgroundColor: AppColors.backgroudWhite,
          const SizedBox(height: 5),
          BlocBuilder<ActivateCubit, ActivateState>(
            builder: (context, state) {
              if (state is GetListActivateSuccess) {
                var filteredListSuccess =
                    state.list.where((item) => item.status == 1).toList();
                var filteredListFail =
                    state.list.where((item) => item.status == 2).toList();
                var filteredListLoading =
                    state.list.where((item) => item.status == 0).toList();
                int totalCountSuccess =
                    filteredListSuccess.length; // Tổng số item có status là 1
                int totalCountFail =
                    filteredListFail.length; // Tổng số item có status là 0
                int totalCountLoading =
                    filteredListLoading.length; // Tổng số item có status là 2
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatisticButton(state.list.length.toString(),
                        LocaleKeys.activateTotal.tr, AppColors.black),
                    const SizedBox(width: 5),
                    _buildStatisticButton(totalCountSuccess.toString(),
                        LocaleKeys.activateSuccess.tr, AppColors.green),
                    const SizedBox(width: 5),
                    _buildStatisticButton(totalCountFail.toString(),
                        LocaleKeys.activateFail.tr, AppColors.error),
                    const SizedBox(width: 5),
                    _buildStatisticButton(totalCountLoading.toString(),
                        LocaleKeys.activatePending.tr, AppColors.blue),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          Expanded(child: BlocBuilder<ActivateCubit, ActivateState>(
            builder: (context, state) {
              if (state is GetListActivateSuccess) {
                return ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return BorderListActivation(
                              listDataActive: state.list[index])
                          .paddingTop(5);
                    });
              }
              return const SizedBox();
            },
          )),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
  Widget _buildStatisticButton(String count, String label, Color borderColor) {
    double screeeWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screeeWidth * 0.2;
    double buttonHeight = buttonWidth * 0.575; // Maintain aspect ratio
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Expanded(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: borderColor, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          ),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown, // điều chỉnh để không tràn ra ngoài
                child: Text(
                  count,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: borderColor),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown, // điều chỉnh để không tràn ra ngoài
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12, color: borderColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
