import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monopoly_banker/data/core/monopoly_electronico/monopoly_electronico_bloc.dart';
import 'package:monopoly_banker/interface/widgets/monopoly_keyboard.dart';

@RoutePage()
class ElectronicGameScreen extends StatelessWidget {
  const ElectronicGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonopolyElectronicoBloc, MonopolyElectronicoState>(
      builder: (context, state) {
        if (state.status == GameStatus.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade200,
              ),
            ),
          );
        }
        return const Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
          bottomNavigationBar: MonopolyTerminal(),
        );
      },
    );
  }
}
