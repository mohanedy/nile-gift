import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/data/index.dart';
import 'package:gift_of_the_nile/domain/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockFavoritesDataSource extends Mock implements FavoritesDataSource {}

class MockCharactersDatasource extends Mock implements CharactersDatasource {}

void main() {
  /// System Under Test
  late FavoritesRepoImpl sut;

  /// Dependencies
  late FavoritesDataSource favoritesDataSource;
  late CharactersDatasource charactersDatasource;

  setUp(() {
    favoritesDataSource = MockFavoritesDataSource();
    charactersDatasource = MockCharactersDatasource();
    sut = FavoritesRepoImpl(
      favoritesDataSource: favoritesDataSource,
      charactersDatasource: charactersDatasource,
    );
  });

  group("FavoritesRepoImpl", () {
    test("Should add character id to favorites when successful", () async {
      /// Arrange
      const character = AncientGodEntity(
        id: 1,
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesDataSource.addFavorite(character.id ?? -1))
          .thenAnswer((_) async => {});

      /// Act
      await sut.addFavorite(character);

      /// Assert
      verify(() => favoritesDataSource.addFavorite(character.id ?? -1))
          .called(1);
      verifyNoMoreInteractions(favoritesDataSource);
    });

    test("Should remove character id from favorites when successful", () async {
      /// Arrange
      const character = AncientGodEntity(
        id: 1,
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesDataSource.removeFavorite(character.id ?? -1))
          .thenAnswer((_) async => {});

      /// Act
      await sut.removeFavorite(character);

      /// Assert
      verify(() => favoritesDataSource.removeFavorite(character.id ?? -1))
          .called(1);
      verifyNoMoreInteractions(favoritesDataSource);
    });

    test("Should return true when character id is in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        id: 1,
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesDataSource.isInFavorites(character.id ?? -1))
          .thenAnswer((_) async => true);

      /// Act
      final result = await sut.isInFavorites(character);

      /// Assert
      verify(() => favoritesDataSource.isInFavorites(character.id ?? -1))
          .called(1);
      expect(result, true);
      verifyNoMoreInteractions(favoritesDataSource);
    });

    test("Should return false when character id is not in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        id: 1,
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesDataSource.isInFavorites(character.id ?? -1))
          .thenAnswer((_) async => false);

      /// Act
      final result = await sut.isInFavorites(character);

      /// Assert
      verify(() => favoritesDataSource.isInFavorites(character.id ?? -1))
          .called(1);
      expect(result, false);
      verifyNoMoreInteractions(favoritesDataSource);
    });

    test("Should return list of favorite characters when successful", () async {
      /// Arrange
      final favoriteIds = [1, 2];
      const ancientGodsData = AncientGodsModel(
        characters: [
          AncientGodModel(
            id: 1,
            name: "Ra",
            about: "God of the sun, order, kings and the sky",
            icon: "assets/images/ancient_gods/ra.png",
          ),
          AncientGodModel(
            id: 2,
            name: "Anubis",
            about: "God of mummification and the afterlife",
            icon: "assets/images/ancient_gods/anubis.png",
          ),
          AncientGodModel(
            id: 3,
            name: "Osiris",
            about: "God of the afterlife, death, life, and resurrection",
            icon: "assets/images/ancient_gods/osiris.png",
          ),
        ],
      );
      const pharaohsData = PharaohsModel(
        characters: [
          PharaohModel(
            id: 4,
            name: "Tutankhamun",
            about: "The boy king who ruled Egypt during the 18th dynasty",
            icon: "assets/images/pharaohs/tutankhamun.png",
          ),
          PharaohModel(
            id: 5,
            name: "Cleopatra",
            about: "The last active ruler of the Ptolemaic Kingdom of Egypt",
            icon: "assets/images/pharaohs/cleopatra.png",
          ),
        ],
      );
      final expectedCharacters = [
        ancientGodsData.characters?[0].toEntity(),
        ancientGodsData.characters?[1].toEntity(),
      ];
      when(() => favoritesDataSource.getFavorites())
          .thenAnswer((_) async => favoriteIds);
      when(() => charactersDatasource.getAncientGods())
          .thenAnswer((_) async => ancientGodsData);
      when(() => charactersDatasource.getPharaohs())
          .thenAnswer((_) async => pharaohsData);

      /// Act
      final result = await sut.getFavorites();

      /// Assert
      verify(() => favoritesDataSource.getFavorites()).called(1);
      verify(() => charactersDatasource.getAncientGods()).called(1);
      verify(() => charactersDatasource.getPharaohs()).called(1);
      expect(result, expectedCharacters);
      verifyNoMoreInteractions(favoritesDataSource);
      verifyNoMoreInteractions(charactersDatasource);
    });
  });
}
