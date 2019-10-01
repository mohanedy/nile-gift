import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';

class DataServiceProvider {
  Future<Map> loadJsonData(String path, BuildContext context) async {
    final data = await DefaultAssetBundle.of(context)
        .loadString(path);
    print(data);
    return jsonDecode(data);
  }

  Future<Characters> loadData(
      BuildContext context, CharacterType characterType) async {
    switch (characterType) {
      case CharacterType.EgyptianGod:
        return AncientGods.fromJson(
            await loadJsonData('resources/data/ancient_gods.json', context));
      case CharacterType.EgyptianPharaohs:
        return Pharaohs.fromJson(
            await loadJsonData('resources/data/pharaohs.json', context));
      default:
        return null;
    }
  }
}
