import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/data/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockJsonUtils extends Mock implements JsonUtils {}

void main() {
  /// System Under Test
  late CharactersDatasourceImpl sut;

  /// Dependencies
  late JsonUtils jsonUtils;

  setUp(() {
    jsonUtils = MockJsonUtils();
    sut = CharactersDatasourceImpl(jsonUtils: jsonUtils);
  });

  group("CharactersDatasourceImpl", () {
    group("getPharaohs", () {
      test("Should return pharaohs model when successful", () async {
        /// Arrange
        final pharaohsMap = {
          "characters": [
            {
              "id": 1,
              "name": "Tutankhamun",
              "about":
              "The boy king who ruled Egypt during the 18th dynasty",
              "icon": "assets/images/pharaohs/tutankhamun.png",
            },
          ]
        };
        final pharaohsModel = PharaohsModel.fromJson(pharaohsMap);
        when(() => jsonUtils.loadJsonData(JsonPaths.pharaohs))
            .thenAnswer((_) async => pharaohsMap);

        /// Act
        final result = await sut.getPharaohs();

        /// Assert
        verify(() => jsonUtils.loadJsonData(JsonPaths.pharaohs)).called(1);
        expect(result, pharaohsModel);
        verifyNoMoreInteractions(jsonUtils);
      });

      test("Should throw an exception when the json utils fails to load the pharaohs data", () async {
        /// Arrange
        when(() => jsonUtils.loadJsonData(JsonPaths.pharaohs))
            .thenThrow(Exception());

        /// Act
        final call = sut.getPharaohs;

        /// Assert
        expect(() => call(), throwsA(isA<Exception>()));
        verify(() => jsonUtils.loadJsonData(JsonPaths.pharaohs)).called(1);
        verifyNoMoreInteractions(jsonUtils);
      });

      test("Should return an empty pharaohs model when there are no pharaohs data",
              () async {
            /// Arrange
            final pharaohsMap = {"characters": []};
            final pharaohsModel = PharaohsModel.fromJson(pharaohsMap);
            when(() => jsonUtils.loadJsonData(JsonPaths.pharaohs))
                .thenAnswer((_) async => pharaohsMap);

            /// Act
            final result = await sut.getPharaohs();

            /// Assert
            verify(() => jsonUtils.loadJsonData(JsonPaths.pharaohs)).called(1);
            expect(result, pharaohsModel);
            expect(result.characters?.isEmpty, true);
            verifyNoMoreInteractions(jsonUtils);
          });
    });

    group("getAncientGods", () {
      test("Should return ancient gods model when successful", () async {
        /// Arrange
        final ancientGodsMap = {
          "characters": [
            {
              "id": 1,
              "name": "Ra",
              "about": "God of the sun, order, kings and the sky",
              "icon": "assets/images/ancient_gods/ra.png",
            },
          ]
        };
        final ancientGodsModel = AncientGodsModel.fromJson(ancientGodsMap);
        when(() => jsonUtils.loadJsonData(JsonPaths.ancientGods))
            .thenAnswer((_) async => ancientGodsMap);

        /// Act
        final result = await sut.getAncientGods();

        /// Assert
        verify(() => jsonUtils.loadJsonData(JsonPaths.ancientGods)).called(1);
        expect(result, ancientGodsModel);
        verifyNoMoreInteractions(jsonUtils);
      });

      test("Should throw an exception when the json utils fails to load the ancient gods data", () async {
        /// Arrange
        when(() => jsonUtils.loadJsonData(JsonPaths.ancientGods))
            .thenThrow(Exception());

        /// Act
        final call = sut.getAncientGods;

        /// Assert
        expect(() => call(), throwsA(isA<Exception>()));
        verify(() => jsonUtils.loadJsonData(JsonPaths.ancientGods)).called(1);
        verifyNoMoreInteractions(jsonUtils);
      });

      test(
          "Should return an empty ancient gods model when there are no ancient gods data",
              () async {
            /// Arrange
            final ancientGodsMap = {"characters": []};
            final ancientGodsModel = AncientGodsModel.fromJson(ancientGodsMap);
            when(() => jsonUtils.loadJsonData(JsonPaths.ancientGods))
                .thenAnswer((_) async => ancientGodsMap);

            /// Act
            final result = await sut.getAncientGods();

            /// Assert
            verify(() => jsonUtils.loadJsonData(JsonPaths.ancientGods)).called(1);
            expect(result, ancientGodsModel);
            expect(result.characters?.isEmpty, true);
            verifyNoMoreInteractions(jsonUtils);
          });
    });
  });
}
