import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class NavBarEvent {}

class ShowNavBar extends NavBarEvent {}

class HideNavBar extends NavBarEvent {}

// State
class NavBarState {
  final bool isVisible;
  NavBarState({required this.isVisible});
}

// Bloc
class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(NavBarState(isVisible: false)) {
    on<ShowNavBar>((event, emit) => emit(NavBarState(isVisible: true)));
    on<HideNavBar>((event, emit) => emit(NavBarState(isVisible: false)));
  }
}
