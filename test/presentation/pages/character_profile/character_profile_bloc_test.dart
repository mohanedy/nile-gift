import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockToggleFavoriteUC extends Mock implements ToggleFavoriteUC {}

const _fakeCharacter = PharaohEntity(
  id: 1,
  name: "Tutankhamun",
  about: "The boy king who ruled Egypt during the 18th dynasty",
  icon: "assets/images/pharaohs/tutankhamun.png",
  date: 1300,
);

void main() {
  /// System Under Test
  late CharacterProfileBloc sut;

  /// Dependencies
  late ToggleFavoriteUC toggleFavoriteUC;

  setUp(() {
    toggleFavoriteUC = MockToggleFavoriteUC();
    sut = CharacterProfileBloc(toggleFavoriteUC: toggleFavoriteUC);
  });

  group("CharacterProfileBloc", () {
    test("Initial state is CharacterProfileState with status as initial", () {
      expect(sut.state, const CharacterProfileState());
    });

    blocTest<CharacterProfileBloc, CharacterProfileState>(
      "Calls toggleFavoriteUC when CharacterFavoritesTriggered event is added",
      build: () {
        when(() => toggleFavoriteUC(_fakeCharacter)).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) =>
          bloc.add(const CharacterFavoritesTriggered(_fakeCharacter)),
      verify: (_) {
        verify(() => toggleFavoriteUC(_fakeCharacter)).called(1);
      },
    );

    blocTest<CharacterProfileBloc, CharacterProfileState>(
      "Does not emit any state when CharacterFavoritesTriggered event is added",
      build: () {
        when(() => toggleFavoriteUC(_fakeCharacter)).thenAnswer((_) async {});
        return sut;
      },
      act: (bloc) =>
          bloc.add(const CharacterFavoritesTriggered(_fakeCharacter)),
      expect: () => [],
    );
  });
}
