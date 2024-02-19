import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servicelocator();
  runApp(const BankerAppNfc());
}

class BankerAppNfc extends StatelessWidget {
  const BankerAppNfc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Banker app',
      routerConfig: getIt<RouterCubit>().state.config(),
    );
  }
}
