import 'package:equatable/equatable.dart';

class CharactersEntity<T> extends Equatable{
  const CharactersEntity({this.characters, this.type});

  final List<T>? characters;
  final String? type;

  @override
  List<Object?> get props => [
    characters,
    type,
  ];
}
