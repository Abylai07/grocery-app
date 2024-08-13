part of 'button_bloc.dart';

@immutable
abstract class ButtonEvent extends Equatable {
  const ButtonEvent();

  @override
  List<Object> get props => [];
}

class ToggleButton extends ButtonEvent {
  final bool isActive;

  const ToggleButton({required this.isActive});

  @override
  List<Object> get props => [isActive];
}
