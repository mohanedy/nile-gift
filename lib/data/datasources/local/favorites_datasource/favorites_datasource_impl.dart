import 'package:gift_of_the_nile/data/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FavoritesDataSource)
final class FavoriteDatasourceImpl implements FavoritesDataSource {
  const FavoriteDatasourceImpl({
    required this.db,
  });

  final HiveDB db;

  @override
  Future<void> addFavorite(int id) async => await db.charactersBox?.put(id, id);

  @override
  Future<List<int>> getFavorites() async =>
      db.charactersBox?.values?.toList() ?? <int>[];

  @override
  Future<void> removeFavorite(int id) async =>
      await db.charactersBox?.delete(id);

  @override
  Future<bool> isInFavorites(int id) async =>
      await db.charactersBox?.containsKey(id) ?? false;
}
