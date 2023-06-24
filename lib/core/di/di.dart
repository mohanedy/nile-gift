import 'package:get_it/get_it.dart';
import 'package:gift_of_the_nile/core/di/di.config.dart';
import 'package:injectable/injectable.dart';

final di = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => di.init();
