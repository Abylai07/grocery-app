part of 'search_product_cubit.dart';

class SearchProductState<T> extends Equatable {
  const SearchProductState({
    this.status = CubitStatus.initial,
    this.entity,
    this.searchHints,
    this.count = 0,
    this.errorCode,
    String? message,
  }) : message = message ?? '';

  final CubitStatus status;
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
    CubitStatus? status,
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