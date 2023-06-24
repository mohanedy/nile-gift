import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path;

@LazySingleton()
class HiveDB {
  Box<int>? charactersBox;

  Future<void> initDB() async {
    final appDocumentDir = await path.getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    charactersBox = await Hive.openBox<int>('charactersBox');
  }
}
