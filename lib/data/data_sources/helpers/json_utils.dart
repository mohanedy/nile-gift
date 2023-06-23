import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class JsonUtils {
  const JsonUtils();

  Future<Map<String, dynamic>> loadJsonData(String path) async {
    final data = await rootBundle.loadString(path);
    return jsonDecode(data);
  }
}
