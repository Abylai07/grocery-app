part of 'button_bloc.dart';

@immutable
abstract class ButtonState extends Equatable {
  const ButtonState();

  @override
  List<Object> get props => [];
}

class ButtonInitial extends ButtonState {}

class ButtonActive extends ButtonState {}

class ButtonInactive extends ButtonState {}
