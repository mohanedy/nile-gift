import 'package:gift_of_the_nile/domain/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetFavoritesUC implements UseCase<List<CharacterEntity>, NoParams> {
  GetFavoritesUC(this._favoritesRepo);

  final FavoritesRepo _favoritesRepo;

  @override
  Future<List<CharacterEntity>> call(NoParams params) async =>
      _favoritesRepo.getFavorites();
}
