import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/core/index.dart';
import 'package:gift_of_the_nile/data/datasources/helpers/hive_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await di<HiveDB>().initDB();
  runApp(App());
}
