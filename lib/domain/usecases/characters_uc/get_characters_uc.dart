import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetCharactersUC implements UseCase<List<CharacterEntity>, NoParams?> {
  const GetCharactersUC({
    required this.charactersRepo,
  });

  final CharactersRepo charactersRepo;

  @override
  Future<List<CharacterEntity>> call(_) async {
    final characters = <CharacterEntity>[];
    final ancientGods = await charactersRepo.getAncientGods();
    final pharaohs = await charactersRepo.getPharaohs();

    characters.addAll(ancientGods.characters ?? []);
    characters.addAll(pharaohs.characters ?? []);

    return characters;
  }
}
