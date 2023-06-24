import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FavoritesRepo)
final class FavoritesRepoImpl implements FavoritesRepo {
  const FavoritesRepoImpl({
    required this.favoritesDataSource,
    required this.charactersDatasource,
  });

  final FavoritesDataSource favoritesDataSource;
  final CharactersDatasource charactersDatasource;

  @override
  Future<void> addFavorite(CharacterEntity character) =>
      favoritesDataSource.addFavorite(character.id ?? -1);

  @override
  Future<List<CharacterEntity>> getFavorites() async {
    final favorites = await favoritesDataSource.getFavorites();
    final ancientGods = await charactersDatasource.getAncientGods();
    final pharaohs = await charactersDatasource.getPharaohs();

    final listOfAncientGods = (ancientGods.characters ?? <AncientGodModel>[])
        .map((e) => e.toEntity());

    final listOfPharaohs =
        (pharaohs.characters ?? <PharaohModel>[]).map((e) => e.toEntity());

    final List<CharacterEntity> characters = [
      ...listOfAncientGods,
      ...listOfPharaohs,
    ];

    return characters
        .where((element) => favorites.contains(element.id ?? -1))
        .toList();
  }

  @override
  Future<void> removeFavorite(CharacterEntity character) =>
      favoritesDataSource.removeFavorite(character.id ?? -1);

  @override
  Future<bool> isInFavorites(CharacterEntity character) async =>
      await favoritesDataSource.isInFavorites(character.id ?? -1);
}
