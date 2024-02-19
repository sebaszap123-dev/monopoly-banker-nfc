import 'package:get_it/get_it.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';

GetIt getIt = GetIt.instance;

void servicelocator() {
  getIt.registerSingleton(RouterCubit());
}
