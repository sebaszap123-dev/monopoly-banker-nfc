import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/database/electronic_preference_v2.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:nfc_manager/nfc_manager.dart';

GetIt getIt = GetIt.instance;
NfcManager _manager = NfcManager.instance;

Future<void> servicelocator() async {
  getIt.allowReassignment = true;
  getIt.registerSingleton(_manager);
  final preferences = ElectronicPreferenceV2();
  await preferences.initialize();
  final monstrance = await BankerManagerService.initDbX();

  // V2 Monopoly electronic
  getIt.registerSingleton(preferences);
  getIt.registerSingleton(monstrance);
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(MonopolyElectronicBloc());
}
