import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:mocktail/mocktail.dart';

/// Mocks
class MockGetCharactersUC extends Mock implements GetCharactersUC {}

const _fakeCharacters = [
  PharaohEntity(
    id: 1,
    name: "Tutankhamun",
    about: "The boy king who ruled Egypt during the 18th dynasty",
    icon: "assets/images/pharaohs/tutankhamun.png",
    date: 1300,
  ),
  PharaohEntity(
    id: 2,
    name: "Cleopatra",
    about: "The last active ruler of the Ptolemaic Kingdom of Egypt",
    icon: "assets/images/pharaohs/cleopatra.png",
    date: 1400,
  ),
];

const _sortedFakeCharacters = [
  PharaohEntity(
    id: 2,
    name: "Cleopatra",
    about: "The last active ruler of the Ptolemaic Kingdom of Egypt",
    icon: "assets/images/pharaohs/cleopatra.png",
    date: 1400,
  ),
  PharaohEntity(
    id: 1,
    name: "Tutankhamun",
    about: "The boy king who ruled Egypt during the 18th dynasty",
    icon: "assets/images/pharaohs/tutankhamun.png",
    date: 1300,
  ),
];

void main() {
  /// System Under Test
  late TimelineBloc sut;

  /// Dependencies
  late GetCharactersUC getCharactersUC;

  setUp(() {
    getCharactersUC = MockGetCharactersUC();
    sut = TimelineBloc(getCharactersUC);
  });

  group("TimelineBloc", () {
    test("Initial state is TimelineState with status as initial", () {
      expect(sut.state, const TimelineState());
    });

    blocTest<TimelineBloc, TimelineState>(
      "Emits [loading, success] when TimelineInitialized event is added and get characters use case is successful",
      build: () {
        when(() => getCharactersUC(const NoParams())).thenAnswer(
          (_) async => List<PharaohEntity>.from(_fakeCharacters),
        );
        return sut;
      },
      act: (bloc) => bloc.add(const TimelineInitialized()),
      expect: () => [
        const TimelineState(status: PageStatus.loading),
        const TimelineState(
          status: PageStatus.success,
          characters: _sortedFakeCharacters,
        ),
      ],
      verify: (_) {
        verify(() => getCharactersUC(const NoParams())).called(1);
      },
    );

    blocTest<TimelineBloc, TimelineState>(
      "Emits [loading, error] when TimelineInitialized event is added and get characters use case throws an exception",
      build: () {
        when(() => getCharactersUC(const NoParams())).thenThrow(Exception());
        return sut;
      },
      act: (bloc) => bloc.add(const TimelineInitialized()),
      expect: () => [
        const TimelineState(status: PageStatus.loading),
        const TimelineState(status: PageStatus.error),
      ],
      verify: (_) {
        verify(() => getCharactersUC(const NoParams())).called(1);
      },
    );
  });
}
