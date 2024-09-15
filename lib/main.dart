import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/config/router/monopoly_router.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/banker_electronic_bloc.dart'
    as Banker;
import 'package:monopoly_banker/data/core/monopoly_electronico_v2/banker_electronic_bloc_v2.dart'
    as BankerV2;
import 'package:monopoly_banker/data/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await servicelocator();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => getIt<Banker.MonopolyElectronicBloc>(),
    ),
    BlocProvider(
      create: (context) => getIt<RouterCubit>(),
    ),
    BlocProvider(
      create: (context) => getIt<BankerV2.ElectronicGameV2Bloc>(),
    ),
  ], child: const BankerAppNfc()));
}

class BankerAppNfc extends StatefulWidget {
  const BankerAppNfc({super.key});

  @override
  State<BankerAppNfc> createState() => _BankerAppNfcState();
}

class _BankerAppNfcState extends State<BankerAppNfc>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      getIt<Banker.MonopolyElectronicBloc>()
          .add(Banker.BackupGameEvent(appPaused: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouterCubit, MonopolyRouter>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Banker app',
          routerConfig: state.config(),
        );
      },
    );
  }
}
