import 'package:gift_of_the_nile/domain/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CheckFavoritesUC implements UseCase<bool, CharacterEntity> {
  CheckFavoritesUC(this._favoritesRepo);

  final FavoritesRepo _favoritesRepo;

  @override
  Future<bool> call(CharacterEntity character) async =>
      _favoritesRepo.isInFavorites(character);
}
