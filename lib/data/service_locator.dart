import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:nfc_manager/nfc_manager.dart';

GetIt getIt = GetIt.instance;
NfcManager _manager = NfcManager.instance;

Future<void> servicelocator() async {
  getIt.registerSingleton(_manager);
  final monservice = await MonopolyElectronicService.initDbX();
  getIt.registerSingleton(monservice);
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(MonopolyGamesStorage());
  getIt.registerSingleton(MonopolyElectronicoBloc());
}
