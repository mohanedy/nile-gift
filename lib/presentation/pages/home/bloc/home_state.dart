part of 'home_bloc.dart';

final class HomeState extends BaseState {
  const HomeState({
    super.status = PageStatus.initial,
    this.characters = const [],
  });

  final List<CharacterEntity> characters;

  List<PharaohEntity> get pharaohs =>
      characters.whereType<PharaohEntity>().toList();

  List<AncientGodEntity> get ancientGods =>
      characters.whereType<AncientGodEntity>().toList();

  HomeState copyWith({
    List<CharacterEntity>? characters,
    PageStatus? status,
  }) {
    return HomeState(
      characters: characters ?? this.characters,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        ...super.props,
        characters,
      ];
}
