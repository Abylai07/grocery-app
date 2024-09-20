//BLoC
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<ToggleSearchVisibility>((event, emit) {
      if (state.isVisible) {
        emit(state.copyWith(isVisible: false));
      } else {
        emit(state.copyWith(isVisible: true));
      }
    });
    on<ToggleWidgetsVisibility>((event, emit) {
      if (state.isShowWidgets) {
        emit(state.copyWith(isShowWidgets: false));
      } else {
        emit(state.copyWith(isShowWidgets: true));
      }
    });
  }
}
