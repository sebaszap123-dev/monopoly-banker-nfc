part of 'monopoly_clasico_bloc.dart';

sealed class MonopolyClasicoState extends Equatable {
  const MonopolyClasicoState();
  
  @override
  List<Object> get props => [];
}

final class MonopolyClasicoInitial extends MonopolyClasicoState {}
