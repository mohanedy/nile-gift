import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockFavoritesRepo extends Mock implements FavoritesRepo {}

void main() {
  /// System Under Test
  late ToggleFavoriteUC sut;

  /// Dependencies
  late FavoritesRepo favoritesRepo;

  setUp(() {
    favoritesRepo = MockFavoritesRepo();
    sut = ToggleFavoriteUC(favoritesRepo);
  });

  group("ToggleFavoriteUC", () {
    test("Should add character to favorites when not in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesRepo.isInFavorites(character))
          .thenAnswer((_) async => false);
      when(() => favoritesRepo.addFavorite(character))
          .thenAnswer((_) async => {});

      /// Act
      await sut.call(character);

      /// Assert
      verify(() => favoritesRepo.isInFavorites(character)).called(1);
      verify(() => favoritesRepo.addFavorite(character)).called(1);
      verifyNoMoreInteractions(favoritesRepo);
    });

    test("Should remove character from favorites when in favorites", () async {
      /// Arrange
      const character = AncientGodEntity(
        name: "Ra",
        about: "God of the sun, order, kings and the sky",
        icon: "assets/images/ancient_gods/ra.png",
      );
      when(() => favoritesRepo.isInFavorites(character))
          .thenAnswer((_) async => true);
      when(() => favoritesRepo.removeFavorite(character))
          .thenAnswer((_) async => {});

      /// Act
      await sut.call(character);

      /// Assert
      verify(() => favoritesRepo.isInFavorites(character)).called(1);
      verify(() => favoritesRepo.removeFavorite(character)).called(1);
      verifyNoMoreInteractions(favoritesRepo);
    });
  });
}
