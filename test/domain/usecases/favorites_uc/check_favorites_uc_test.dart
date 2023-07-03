import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/domain/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockFavoritesRepo extends Mock implements FavoritesRepo {}

void main() {
  /// System Under Test
  late CheckFavoritesUC sut;

  /// Dependencies
  late FavoritesRepo favoritesRepo;

  setUp(() {
    favoritesRepo = MockFavoritesRepo();
    sut = CheckFavoritesUC(favoritesRepo);
  });

  group("CheckFavoritesUC", () {
    test("Should return true when character is in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesRepo.isInFavorites(character))
          .thenAnswer((_) async => true);

      /// Act
      final result = await sut.call(character);

      /// Assert
      verify(() => favoritesRepo.isInFavorites(character)).called(1);
      expect(result, true);
      verifyNoMoreInteractions(favoritesRepo);
    });

    test("Should return false when character is not in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesRepo.isInFavorites(character))
          .thenAnswer((_) async => false);

      /// Act
      final result = await sut.call(character);

      /// Assert
      verify(() => favoritesRepo.isInFavorites(character)).called(1);
      expect(result, false);
      verifyNoMoreInteractions(favoritesRepo);
    });
  });
}
