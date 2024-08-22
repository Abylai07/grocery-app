part of 'search_product_cubit.dart';

enum SearchStatus { initial, successHint, searchSubmit, success, error, loading}

extension SearchStatusX on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;
  bool get isSearchSubmit => this == SearchStatus.searchSubmit;
  bool get isSuccess => this == SearchStatus.success;
  bool get isSuccessHint => this == SearchStatus.successHint;
  bool get isError => this == SearchStatus.error;
  bool get isLoading => this == SearchStatus.loading;
}

class SearchProductState<T> extends Equatable {
  const SearchProductState({
    this.status = SearchStatus.initial,
    this.entity,
    this.searchHints,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final SearchStatus status;
  final List<ProductEntity>? entity;
  final List<SearchHintEntity>? searchHints;
  final String message;
  final int count;
  final int? errorCode;

  @override
  List<Object?> get props => [
    status,
    entity,
    searchHints,
    message,
    count,
    errorCode,
  ];

  SearchProductState copyWith({
    List<ProductEntity>? entity,
    List<SearchHintEntity>? searchHints,
    SearchStatus? status,
    String? message,
    int? count,
    int? errorCode,
  }) {
    return SearchProductState(
      errorCode: errorCode,
      entity: entity ?? this.entity,
      searchHints: searchHints ?? this.searchHints,
      status: status ?? this.status,
      message: message ?? this.message,
      count: count ?? this.count,
    );
  }
}