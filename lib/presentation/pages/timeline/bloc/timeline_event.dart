part of 'timeline_bloc.dart';

@immutable
sealed class TimelineEvent  extends Equatable{
  const TimelineEvent();
}

final class TimelineInitialized extends TimelineEvent{
  const TimelineInitialized();

  @override
  List<Object?> get props => [];
}
