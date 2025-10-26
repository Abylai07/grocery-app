part of 'search_bloc.dart';

abstract class SearchEvent {}

// Toggle the visibility of the search bar.
class ToggleSearchVisibility extends SearchEvent {}

class ToggleWidgetsVisibility extends SearchEvent {}

class CloseSearch extends SearchEvent {}

