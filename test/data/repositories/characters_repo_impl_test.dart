import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/data/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockCharactersDataSource extends Mock implements CharactersDatasource {}

void main() {
  /// System Under Test
  late CharactersRepoImpl sut;

  /// Dependencies
  late CharactersDatasource charactersDataSource;

  setUp(() {
    charactersDataSource = MockCharactersDataSource();
    sut = CharactersRepoImpl(charactersDataSource: charactersDataSource);
  });

  group("CharactersRepoImpl", () {
    test("Should return ancient gods entity when successful", () async {
      /// Arrange
      const data = AncientGodsModel(
        characters: [
          AncientGodModel(
            name: "Ra",
            about: "God of the sun, order, kings and the sky",
            icon: "assets/images/ancient_gods/ra.png",
          ),
        ],
      );
      final entity = data.toEntity();
      when(() => charactersDataSource.getAncientGods())
          .thenAnswer((_) async => data);

      /// Act
      final result = await sut.getAncientGods();

      /// Assert
      verify(() => charactersDataSource.getAncientGods()).called(1);
      expect(result, entity);
      verifyNoMoreInteractions(charactersDataSource);
    });

    test("Should return pharaohs entity when successful", () async {
      /// Arrange
      const data = PharaohsModel(
        characters: [
          PharaohModel(
            name: "Tutankhamun",
            about: "The boy king who ruled Egypt during the 18th dynasty",
            icon: "assets/images/pharaohs/tutankhamun.png",
          ),
        ],
      );
      final entity = data.toEntity();
      when(() => charactersDataSource.getPharaohs())
          .thenAnswer((_) async => data);

      /// Act
      final result = await sut.getPharaohs();

      /// Assert
      verify(() => charactersDataSource.getPharaohs()).called(1);
      expect(result, entity);
      verifyNoMoreInteractions(charactersDataSource);
    });

    test(
        "Should throw an exception when the characters data source fails to get the ancient gods",
        () async {
      /// Arrange
      when(() => charactersDataSource.getAncientGods()).thenThrow(Exception());

      /// Act
      final call = sut.getAncientGods;

      /// Assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(() => charactersDataSource.getAncientGods()).called(1);
      verifyNoMoreInteractions(charactersDataSource);
    });
    test(
        "Should throw an exception when the characters data source fails to get the pharaohs",
        () async {
      /// Arrange
      when(() => charactersDataSource.getPharaohs()).thenThrow(Exception());

      /// Act
      final call = sut.getPharaohs;

      /// Assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(() => charactersDataSource.getPharaohs()).called(1);
      verifyNoMoreInteractions(charactersDataSource);
    });

    test(
        "Should return an empty ancient gods entity when there are no ancient gods",
        () async {
      /// Arrange
      const data = AncientGodsModel(characters: []);
      final entity = data.toEntity();
      when(() => charactersDataSource.getAncientGods())
          .thenAnswer((_) async => data);

      /// Act
      final result = await sut.getAncientGods();

      /// Assert
      verify(() => charactersDataSource.getAncientGods()).called(1);
      expect(result, entity);
      expect(result.characters?.isEmpty, true);
      verifyNoMoreInteractions(charactersDataSource);
    });

    test("Should return an empty pharaohs entity when there are no pharaohs",
        () async {
      /// Arrange
      const data = PharaohsModel(characters: []);
      final entity = data.toEntity();
      when(() => charactersDataSource.getPharaohs())
          .thenAnswer((_) async => data);

      /// Act
      final result = await sut.getPharaohs();

      /// Assert
      verify(() => charactersDataSource.getPharaohs()).called(1);
      expect(result, entity);
      expect(result.characters?.isEmpty, true);
      verifyNoMoreInteractions(charactersDataSource);
    });
  });
}
