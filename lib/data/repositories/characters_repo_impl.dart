import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CharactersRepo)
final class CharactersRepoImpl implements CharactersRepo {
  const CharactersRepoImpl({
    required this.charactersDataSource,
  });

  final CharactersDatasource charactersDataSource;

  @override
  Future<AncientGodsEntity> getAncientGods()async {
    final data = await charactersDataSource.getAncientGods();
    return data.toEntity();
  }

  @override
  Future<PharaohsEntity> getPharaohs()async {
    final data = await charactersDataSource.getPharaohs();
    return data.toEntity();
  }
}
