import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ObscureEvent {}

class ToggleVisibilityEvent extends ObscureEvent {}

// States
abstract class ObscureState {}

class TextFieldVisibilityState extends ObscureState {
  final bool isTextVisible;

  TextFieldVisibilityState(this.isTextVisible);
}

// BLoC
class ObscureBloc extends Bloc<ObscureEvent, ObscureState> {
  ObscureBloc() : super(TextFieldVisibilityState(false)) {
    on<ToggleVisibilityEvent>(_onToggleVisibilityEvent);
  }

  void _onToggleVisibilityEvent(ToggleVisibilityEvent event, Emitter<ObscureState> emit) {
    final currentState = state as TextFieldVisibilityState;
    emit(TextFieldVisibilityState(!currentState.isTextVisible));
  }
}
