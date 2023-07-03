import 'package:gift_of_the_nile/domain/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ToggleFavoriteUC implements UseCase<void, CharacterEntity> {
  ToggleFavoriteUC(this._favoritesRepo);

  final FavoritesRepo _favoritesRepo;

  @override
  Future<void> call(CharacterEntity character) async {
    if (await _favoritesRepo.isInFavorites(character)) {
      await _favoritesRepo.removeFavorite(character);
    } else {
      await _favoritesRepo.addFavorite(character);
    }
  }
}
