import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stiebel_etron_warranty/bloc/cores/cores_bloc_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/cubit/login_cubit.dart';
import 'package:stiebel_etron_warranty/storage/app_preferences.dart';
import '../bloc/account/account_cubit.dart';
import '../bloc/activate/activate_cubit.dart';
import '../bloc/address/address_cubit.dart';
import '../bloc/warranty_station/warranty_station_cubit.dart';

class WrapProvider extends StatelessWidget {
  const WrapProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AppPreferencesImpl>(create: (context) => AppPreferencesImpl()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CoresBlocCubit>(
              create: (BuildContext context) => CoresBlocCubit(),
            ),
            BlocProvider<AddressCubit>(
              create: (BuildContext context) => AddressCubit(),
            ),
            BlocProvider<ActivateCubit>(
              create: (BuildContext context) => ActivateCubit(),
            ),
            BlocProvider<AccountCubit>(
              create: (BuildContext context) => AccountCubit(),
            ),
            BlocProvider<WarrantyStationCubit>(
              create: (BuildContext context) => WarrantyStationCubit(),
            ),
             BlocProvider<LoginCubit>(
              create: (BuildContext context) => LoginCubit(),
            ),
          ],
          child: child,
        ));
  }
}
