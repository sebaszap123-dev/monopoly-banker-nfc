import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'monopoly_clasico_event.dart';
part 'monopoly_clasico_state.dart';

class MonopolyClasicoBloc
    extends Bloc<MonopolyClasicoEvent, MonopolyClasicoState> {
  MonopolyClasicoBloc() : super(MonopolyClasicoInitial()) {
    on<MonopolyClasicoEvent>((event, emit) {
      // TODO-FEATURE: implement event handler
    });
  }
}
