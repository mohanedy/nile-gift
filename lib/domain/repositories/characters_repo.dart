import 'package:gift_of_the_nile/index.dart';

abstract interface class CharactersRepo {
  Future<PharaohsEntity> getPharaohs();

  Future<AncientGodsEntity> getAncientGods();
}
