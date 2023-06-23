import 'package:gift_of_the_nile/domain/usecases/characters_uc/characters_uc.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CharactersUC)
final class CharactersUCImpl implements CharactersUC {
  const CharactersUCImpl({
    required this.charactersRepo,
  });

  final CharactersRepo charactersRepo;

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    final characters = <CharacterEntity>[];
    final ancientGods = await charactersRepo.getAncientGods();
    final pharaohs = await charactersRepo.getPharaohs();

    characters.addAll(ancientGods.characters ?? []);
    characters.addAll(pharaohs.characters ?? []);

    return characters;
  }
}
