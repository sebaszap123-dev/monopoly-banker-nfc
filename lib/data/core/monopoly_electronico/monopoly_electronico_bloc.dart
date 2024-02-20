import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monopoly_banker/data/model/monopoly_cards.dart';
import 'package:monopoly_banker/data/model/monopoly_player.dart';
import 'package:monopoly_banker/data/service/monopoly_electronic_service.dart';
import 'package:monopoly_banker/data/service/secure_storage.dart';
import 'package:monopoly_banker/data/service_locator.dart';

part 'monopoly_electronico_event.dart';
part 'monopoly_electronico_state.dart';

class MonopolyElectronicoBloc
    extends Bloc<MonopolyElectronicoEvent, MonopolyElectronicoState> {
  MonopolyElectronicoBloc() : super(const MonopolyElectronicoState()) {
    on<HandleCardsEvent>(_handleCardsEvent);
    on<StartGameEvent>(_startGameEvent);
  }
  _handleCardsEvent(
      HandleCardsEvent event, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    final hasSavedGames = await getIt<MonopolyGamesStorage>().hasCurrentGames;
    final cards =
        await getIt<MonopolyElectronicService>().getAllMonopolyCards();
    emit(state.copyWith(
      cards: cards,
      status: GameStatus.success,
      hasSavedGame: hasSavedGames,
    ));
  }

  _startGameEvent(
      StartGameEvent event, Emitter<MonopolyElectronicoState> emit) async {
    emit(state.copyWith(status: GameStatus.loading));
    await Future.delayed(const Duration(milliseconds: 900));
    await getIt<MonopolyGamesStorage>().startGameX();
    emit(state.copyWith(players: event.players, status: GameStatus.playing));
  }
}
