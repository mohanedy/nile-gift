import 'package:gift_of_the_nile/domain/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FavoriteUC)
final class FavoriteUCImpl implements FavoriteUC {
  final FavoritesRepo _repository;

  FavoriteUCImpl(this._repository);

  @override
  Future<void> addFavorite(CharacterEntity character) async {
    await _repository.addFavorite(character);
  }

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    return  _repository.getFavorites();
  }

  @override
  Future<void> removeFavorite(CharacterEntity character) async {
    await _repository.removeFavorite(character);
  }

  @override
  Future<bool> isInFavorites(CharacterEntity character)async =>
      _repository.isInFavorites(character);
}
