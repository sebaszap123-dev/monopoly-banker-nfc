import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';

GetIt getIt = GetIt.instance;

Future<void> servicelocator() async {
  final monservice = await MonopolyElectronicService.initDbX();
  getIt.registerSingleton(monservice);
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(MonopolyGamesStorage());
  getIt.registerSingleton(MonopolyElectronicoBloc());
}
