import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';

class DataServiceProvider {
  Future<Map> loadJsonData(String path, BuildContext context) async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('resources/data/ancient_gods.json');
    print(data);
    return jsonDecode(data);
  }

  Future<AncientGods> loadData(BuildContext context) async {
    return AncientGods.fromJson(
        await loadJsonData('resources/data/ancient_gods.json', context));
  }
}
