import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/domain/index.dart';
import 'package:gift_of_the_nile/presentation/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockGetCharactersUC extends Mock implements GetCharactersUC {}

void main() {
  /// System Under Test
  late HomeBloc sut;

  /// Dependencies
  late GetCharactersUC getCharactersUC;

  setUp(() {
    getCharactersUC = MockGetCharactersUC();
    sut = HomeBloc(getCharactersUC);
  });

  group("HomeBloc", () {
    test("Initial state is HomeState with status as initial", () {
      expect(sut.state, const HomeState());
    });

    blocTest<HomeBloc, HomeState>(
      "Emits [loading, success] when HomeInitialized event is added and get characters use case is successful",
      build: () {
        final characters = [
          const AncientGodEntity(
            id: 1,
            name: "Ra",
            about: "God of the sun, order, kings and the sky",
            icon: "assets/images/ancient_gods/ra.png",
          ),
        ];
        when(() => getCharactersUC(const NoParams()))
            .thenAnswer((_) async => characters);
        return sut;
      },
      act: (bloc) => bloc.add(const HomeInitialized()),
      expect: () => [
        const HomeState(status: PageStatus.loading),
        const HomeState(
          status: PageStatus.success,
          characters: [
            AncientGodEntity(
              id: 1,
              name: "Ra",
              about: "God of the sun, order, kings and the sky",
              icon: "assets/images/ancient_gods/ra.png",
            ),
          ],
        ),
      ],
      verify: (_) {
        verify(() => getCharactersUC(const NoParams())).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      "Emits [loading, error] when HomeInitialized event is added and get characters use case throws an exception",
      build: () {
        when(() => getCharactersUC(const NoParams())).thenThrow(Exception());
        return sut;
      },
      act: (bloc) => bloc.add(const HomeInitialized()),
      expect: () => [
        const HomeState(status: PageStatus.loading),
        const HomeState(status: PageStatus.error),
      ],
      verify: (_) {
        verify(() => getCharactersUC(const NoParams())).called(1);
      },
    );
  });
}
