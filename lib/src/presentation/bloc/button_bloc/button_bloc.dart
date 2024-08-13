import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'button_event.dart';
part 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonInitial()) {
    on<ToggleButton>((event, emit) {
      if (event.isActive) {
        emit(ButtonActive());
      } else {
        emit(ButtonInactive());
      }
    });
  }
}
