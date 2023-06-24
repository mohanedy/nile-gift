abstract interface class FavoritesDataSource {
  Future<List<int>> getFavorites();

  Future<void> addFavorite(int id);

  Future<void> removeFavorite(int id);

  Future<bool> isInFavorites(int id);
}
