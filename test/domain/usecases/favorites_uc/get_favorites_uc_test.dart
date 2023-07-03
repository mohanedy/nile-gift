import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockFavoritesRepo extends Mock implements FavoritesRepo {}

void main() {
  /// System Under Test
  late GetFavoritesUC sut;

  /// Dependencies
  late FavoritesRepo favoritesRepo;

  setUp(() {
    favoritesRepo = MockFavoritesRepo();
    sut = GetFavoritesUC(favoritesRepo);
  });

  test("Should return list of favorite characters when successful", () async {
    /// Arrange
    when(() => favoritesRepo.getFavorites()).thenAnswer(
      (_) async => [
        const AncientGodEntity(
          name: "Osiris",
          about: "God of the afterlife, death, life, and resurrection",
          icon: "assets/images/ancient_gods/osiris.png",
        ),
      ],
    );

    /// Act
    final result = await sut(const NoParams());

    /// Assert
    verify(() => favoritesRepo.getFavorites()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, 1);
    expect(result[0], isA<AncientGodEntity>());
    verifyNoMoreInteractions(favoritesRepo);
  });

  test("Should return a list of mixed favorite characters when successful",
      () async {
    /// Arrange
    when(() => favoritesRepo.getFavorites()).thenAnswer(
      (_) async => [
        const AncientGodEntity(
          name: "Anubis",
          about: "God of mummification and the afterlife",
          icon: "assets/images/ancient_gods/anubis.png",
        ),
        const PharaohEntity(
          name: "Cleopatra",
          about: "The last active ruler of the Ptolemaic Kingdom of Egypt",
          icon: "assets/images/pharaohs/cleopatra.png",
        ),
      ],
    );

    /// Act
    final result = await sut(const NoParams());

    /// Assert
    verify(() => favoritesRepo.getFavorites()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, 2);
    expect(result[0], isA<AncientGodEntity>());
    expect(result[1], isA<PharaohEntity>());
    verifyNoMoreInteractions(favoritesRepo);
  });

  test("Should return a list of favorite pharaohs when successful", () async {
    /// Arrange
    when(() => favoritesRepo.getFavorites()).thenAnswer(
      (_) async => [
        const PharaohEntity(
          name: "Tutankhamun",
          about: "The boy king who ruled Egypt during the 18th dynasty",
          icon: "assets/images/pharaohs/tutankhamun.png",
        ),
      ],
    );

    /// Act
    final result = await sut(const NoParams());

    /// Assert
    verify(() => favoritesRepo.getFavorites()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, 1);
    expect(result[0], isA<PharaohEntity>());
    verifyNoMoreInteractions(favoritesRepo);
  });
  test("Should return an empty list when there are no favorite characters",
      () async {
    /// Arrange
    when(() => favoritesRepo.getFavorites()).thenAnswer(
      (_) async => [],
    );

    /// Act
    final result = await sut(const NoParams());

    /// Assert
    verify(() => favoritesRepo.getFavorites()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.isEmpty, true);
    verifyNoMoreInteractions(favoritesRepo);
  });

  test(
      "Should throw an exception when the favorites repo fails to get the favorites",
      () async {
    /// Arrange
    when(() => favoritesRepo.getFavorites()).thenThrow(Exception());

    /// Act
    final call = sut;

    /// Assert
    expect(() => call(const NoParams()), throwsA(isA<Exception>()));
    verify(() => favoritesRepo.getFavorites()).called(1);
    verifyNoMoreInteractions(favoritesRepo);
  });
}
