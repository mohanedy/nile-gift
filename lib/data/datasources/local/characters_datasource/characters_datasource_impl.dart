import 'package:gift_of_the_nile/data/index.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: CharactersDatasource)
final class CharactersDatasourceImpl implements CharactersDatasource {
  const CharactersDatasourceImpl({
    required this.jsonUtils,
  });

  final JsonUtils jsonUtils;

  @override
  Future<PharaohsModel> getPharaohs() async {
    final pharaohsMap = await jsonUtils.loadJsonData(JsonPaths.pharaohs);
    return PharaohsModel.fromJson(pharaohsMap);
  }

  @override
  Future<AncientGodsModel> getAncientGods() async {
    final ancientGodsMap = await jsonUtils.loadJsonData(JsonPaths.ancientGods);
    return AncientGodsModel.fromJson(ancientGodsMap);
  }
}
