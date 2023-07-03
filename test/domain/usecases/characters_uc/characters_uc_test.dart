import 'package:flutter_test/flutter_test.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:mocktail/mocktail.dart';

class MockCharactersRepo extends Mock implements CharactersRepo {}

void main() {
  /// [sut] System Under Test
  late CharactersUC sut;

  late MockCharactersRepo charactersRepo;

  final List<AncientGodEntity> fakeAncientGodsData = [
    const AncientGodEntity(
      name: "Osiris",
      about: "God of the afterlife, death, life, and resurrection",
      icon: "assets/images/ancient_gods/osiris.png",
    ),
  ];

  final List<PharaohEntity> fakePharaohsData = [
    const PharaohEntity(
      name: "Khufu",
      about: "The Great Pyramid of Giza",
      icon: "assets/images/pharaohs/khufu.png",
    ),
  ];

  setUp(() {
    charactersRepo = MockCharactersRepo();
    sut = CharactersUCImpl(charactersRepo: charactersRepo);
  });

  test("Should return list of characters when successful", () async {
    /// Arrange
    when(() => charactersRepo.getAncientGods()).thenAnswer(
      (_) async => AncientGodsEntity(
        characters: fakeAncientGodsData,
        type: CharacterType.ancientGod.stringName,
      ),
    );
    when(() => charactersRepo.getPharaohs()).thenAnswer(
      (_) async => PharaohsEntity(
        characters: fakePharaohsData,
        type: CharacterType.pharaoh.stringName,
      ),
    );

    /// Act
    final result = await sut.getCharacters();

    /// Assert
    verify(() => charactersRepo.getAncientGods()).called(1);
    verify(() => charactersRepo.getPharaohs()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, 2);
    expect(result[0], isA<AncientGodEntity>());
    expect(result[1], isA<PharaohEntity>());
    verifyNoMoreInteractions(charactersRepo);
  });

  test("Should throw an exception when the charactersRepo is null", () {
    /// Arrange
    when(() => charactersRepo.getAncientGods()).thenAnswer(
      (_) async => throw UnimplementedError(),
    );

    /// Act
    final call = sut.getCharacters;

    /// Assert
    expect(() => call(), throwsA(isA<UnimplementedError>()));
  });

  test("Should return an empty list when the charactersRepo returns no data",
      () async {
    /// Arrange
    when(() => charactersRepo.getAncientGods()).thenAnswer(
      (_) async => AncientGodsEntity(
        characters: [],
        type: CharacterType.ancientGod.stringName,
      ),
    );
    when(() => charactersRepo.getPharaohs()).thenAnswer(
      (_) async => PharaohsEntity(
        characters: [],
        type: CharacterType.pharaoh.stringName,
      ),
    );

    /// Act
    final result = await sut.getCharacters();

    /// Assert
    verify(() => charactersRepo.getAncientGods()).called(1);
    verify(() => charactersRepo.getPharaohs()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.isEmpty, true);
    verifyNoMoreInteractions(charactersRepo);
  });

  test(
      "Should return only ancient gods when the charactersRepo returns only ancient gods",
      () async {
    /// Arrange
    when(() => charactersRepo.getAncientGods()).thenAnswer(
      (_) async => AncientGodsEntity(
        characters: fakeAncientGodsData,
        type: CharacterType.ancientGod.stringName,
      ),
    );
    when(() => charactersRepo.getPharaohs()).thenAnswer(
      (_) async => PharaohsEntity(
        characters: [],
        type: CharacterType.pharaoh.stringName,
      ),
    );

    /// Act
    final result = await sut.getCharacters();

    /// Assert
    verify(() => charactersRepo.getAncientGods()).called(1);
    verify(() => charactersRepo.getPharaohs()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, fakeAncientGodsData.length);
    expect(result[0], isA<AncientGodEntity>());
    verifyNoMoreInteractions(charactersRepo);
  });

  test(
      "Should return only pharaohs when the charactersRepo returns only pharaohs",
      () async {
    /// Arrange
    when(() => charactersRepo.getAncientGods()).thenAnswer(
      (_) async => AncientGodsEntity(
        characters: [],
        type: CharacterType.ancientGod.stringName,
      ),
    );
    when(() => charactersRepo.getPharaohs()).thenAnswer(
      (_) async => PharaohsEntity(
        characters: fakePharaohsData,
        type: CharacterType.pharaoh.stringName,
      ),
    );

    /// Act
    final result = await sut.getCharacters();

    /// Assert
    verify(() => charactersRepo.getAncientGods()).called(1);
    verify(() => charactersRepo.getPharaohs()).called(1);
    expect(result, isA<List<CharacterEntity>>());
    expect(result.length, fakePharaohsData.length);
    expect(result[0], isA<PharaohEntity>());
    verifyNoMoreInteractions(charactersRepo);
  });
}
