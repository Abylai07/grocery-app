import 'package:equatable/equatable.dart';

class SearchHintEntity extends Equatable {
  final int id;
  final Map<String, String> name;

  const SearchHintEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}