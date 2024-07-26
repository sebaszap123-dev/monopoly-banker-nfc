import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart';
import 'package:monopoly_banker/data/service/banker_manager_service.dart';
import 'package:monopoly_banker/data/service/banker_preferences.dart';
import 'package:monopoly_banker/data/service/game_sessions_service.dart';
import 'package:nfc_manager/nfc_manager.dart';

GetIt getIt = GetIt.instance;
NfcManager _manager = NfcManager.instance;

Future<void> servicelocator() async {
  getIt.allowReassignment = true;
  getIt.registerSingleton(_manager);
  final monstrance = await BankerManagerService.initDbX();
  getIt.registerSingleton(monstrance);
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(GameSessionsService());
  getIt.registerSingleton(BankerPreferences());
  getIt.registerSingleton(MonopolyElectronicBloc());
}
