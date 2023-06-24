part of 'timeline_bloc.dart';

@immutable
final class TimelineState extends BaseState {
  const TimelineState({
    super.status = PageStatus.initial,
    this.characters = const <CharacterEntity>[],
  });

  final List<CharacterEntity> characters;

  TimelineState copyWith({
    List<CharacterEntity>? characters,
    PageStatus? status,
  }) {
    return TimelineState(
      characters: characters ?? this.characters,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => super.props
    ..addAll([
      characters,
    ]);
}
