import 'package:equatable/equatable.dart';

class CharactersModel<T> extends Equatable {
  const CharactersModel({this.characters, this.type});

  final List<T>? characters;
  final String? type;

  @override
  List<Object?> get props => [
        characters,
        type,
      ];
}
