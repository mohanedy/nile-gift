import 'package:gift_of_the_nile/data/index.dart';

abstract interface class CharactersDatasource{
  Future<PharaohsModel> getPharaohs();
  Future<AncientGodsModel> getAncientGods();
}