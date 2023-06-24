part of 'character_profile_bloc.dart';

sealed class CharacterProfileEvent extends Equatable {
  const CharacterProfileEvent();
}

/// Event to add/remove a character to favorites
final class CharacterFavoritesTriggered extends CharacterProfileEvent {
  const CharacterFavoritesTriggered(this.character);

  final CharacterEntity character;

  @override
  List<Object?> get props => [character];
}
