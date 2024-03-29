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

import '../../data/datasources/helpers/hive_db.dart' as _i3;
import '../../data/datasources/helpers/json_utils.dart' as _i4;
import '../../data/datasources/local/characters_datasource/characters_datasource_impl.dart'
    as _i6;
import '../../data/datasources/local/favorites_datasource/favorites_datasource_impl.dart'
    as _i9;
import '../../data/index.dart' as _i5;
import '../../data/repositories/characters_repo_impl.dart' as _i8;
import '../../data/repositories/favorites_repo_impl.dart' as _i10;
import '../../domain/index.dart' as _i13;
import '../../domain/usecases/characters_uc/get_characters_uc.dart' as _i11;
import '../../domain/usecases/favorites_uc/check_favorites_uc.dart' as _i18;
import '../../domain/usecases/favorites_uc/get_favorites_uc.dart' as _i12;
import '../../domain/usecases/favorites_uc/toggle_favorite_uc.dart' as _i16;
import '../../index.dart' as _i7;
import '../../presentation/pages/character_profile/bloc/character_profile_bloc.dart'
    as _i17;
import '../../presentation/pages/home/bloc/home_bloc.dart' as _i14;
import '../../presentation/pages/timeline/bloc/timeline_bloc.dart' as _i15;

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
    gh.lazySingleton<_i3.HiveDB>(() => _i3.HiveDB());
    gh.lazySingleton<_i4.JsonUtils>(() => _i4.JsonUtils());
    gh.lazySingleton<_i5.CharactersDatasource>(
        () => _i6.CharactersDatasourceImpl(jsonUtils: gh<_i5.JsonUtils>()));
    gh.lazySingleton<_i7.CharactersRepo>(() => _i8.CharactersRepoImpl(
        charactersDataSource: gh<_i7.CharactersDatasource>()));
    gh.lazySingleton<_i5.FavoritesDataSource>(
        () => _i9.FavoriteDatasourceImpl(db: gh<_i5.HiveDB>()));
    gh.lazySingleton<_i7.FavoritesRepo>(() => _i10.FavoritesRepoImpl(
          favoritesDataSource: gh<_i7.FavoritesDataSource>(),
          charactersDatasource: gh<_i7.CharactersDatasource>(),
        ));
    gh.lazySingleton<_i11.GetCharactersUC>(
        () => _i11.GetCharactersUC(charactersRepo: gh<_i7.CharactersRepo>()));
    gh.lazySingleton<_i12.GetFavoritesUC>(
        () => _i12.GetFavoritesUC(gh<_i13.FavoritesRepo>()));
    gh.factory<_i14.HomeBloc>(() => _i14.HomeBloc(gh<_i7.GetCharactersUC>()));
    gh.factory<_i15.TimelineBloc>(
        () => _i15.TimelineBloc(gh<_i7.GetCharactersUC>()));
    gh.lazySingleton<_i16.ToggleFavoriteUC>(
        () => _i16.ToggleFavoriteUC(gh<_i13.FavoritesRepo>()));
    gh.factory<_i17.CharacterProfileBloc>(() => _i17.CharacterProfileBloc(
        toggleFavoriteUC: gh<_i7.ToggleFavoriteUC>()));
    gh.lazySingleton<_i18.CheckFavoritesUC>(
        () => _i18.CheckFavoritesUC(gh<_i13.FavoritesRepo>()));
    return this;
  }
}
