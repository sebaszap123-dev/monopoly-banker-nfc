import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart';
import 'package:monopoly_banker/data/database/electronic_database_v2.dart';
import 'package:monopoly_banker/data/database/electronic_preference_v2.dart';
import 'package:nfc_manager/nfc_manager.dart';

GetIt getIt = GetIt.instance;
NfcManager _manager = NfcManager.instance;

Future<void> servicelocator() async {
  getIt.allowReassignment = true;
  getIt.registerSingleton(_manager);
  // V2
  final preferences = ElectronicPreferenceV2();
  final databaseV2 = ElectronicDatabaseV2();
  await databaseV2.initialize();
  await preferences.initialize();

  // V1
  getIt.registerSingleton(RouterCubit());

  // V2 Monopoly electronic
  getIt.registerSingleton(preferences);
  getIt.registerSingleton(databaseV2);
  getIt.registerSingleton(ElectronicGameV2Bloc());
}
