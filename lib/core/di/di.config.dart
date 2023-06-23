// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_sources/helpers/json_utils.dart' as _i3;
import '../../data/data_sources/local/characters_data_source/characters_data_source_impl.dart'
    as _i5;
import '../../data/index.dart' as _i4;
import '../../data/repositories/characters_repo_impl.dart' as _i7;
import '../../domain/usecases/characters_uc/characters_uc.dart' as _i8;
import '../../domain/usecases/characters_uc/characters_uc_impl.dart' as _i9;
import '../../index.dart' as _i6;
import '../../presentation/pages/home/bloc/home_bloc.dart' as _i10;
import '../../presentation/pages/timeline/bloc/timeline_bloc.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.JsonUtils>(() => _i3.JsonUtils());
    gh.lazySingleton<_i4.CharactersDataSource>(
        () => _i5.CharactersDataSourceImpl(jsonUtils: gh<_i4.JsonUtils>()));
    gh.lazySingleton<_i6.CharactersRepo>(() => _i7.CharactersRepoImpl(
        charactersDataSource: gh<_i6.CharactersDataSource>()));
    gh.lazySingleton<_i8.CharactersUC>(
        () => _i9.CharactersUCImpl(charactersRepo: gh<_i6.CharactersRepo>()));
    gh.factory<_i10.HomeBloc>(() => _i10.HomeBloc(gh<_i6.CharactersUC>()));
    gh.factory<_i11.TimelineBloc>(
        () => _i11.TimelineBloc(gh<_i6.CharactersUC>()));
    return this;
  }
}
