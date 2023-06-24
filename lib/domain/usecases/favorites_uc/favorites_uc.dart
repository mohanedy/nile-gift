import 'package:gift_of_the_nile/domain/entities/character_entity.dart';

abstract interface class FavoriteUC {
  Future<List<CharacterEntity>> getFavorites();

  Future<void> addFavorite(CharacterEntity character);

  Future<void> removeFavorite(CharacterEntity character);

  Future<bool> isInFavorites(CharacterEntity character);
}
