part of 'search_bloc.dart';

class SearchState<T> extends Equatable {
  final bool isVisible;                       // Whether the search bar is visible
  final bool isShowWidgets;                // Whether the user has started typing

  const SearchState({
    this.isVisible = false,
    this.isShowWidgets = false,
  });

  SearchState<T> copyWith({
    bool? isVisible,
    bool? isShowWidgets,
  }) {
    return SearchState<T>(
      isVisible: isVisible ?? this.isVisible,
      isShowWidgets: isShowWidgets ?? this.isShowWidgets,
    );
  }

  @override
  List<Object?> get props => [
    isVisible,
    isShowWidgets,
  ];
}
