import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/data/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servicelocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => getIt<MonopolyElectronicoBloc>(),
    ),
  ], child: const BankerAppNfc()));
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
