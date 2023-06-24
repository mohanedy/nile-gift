import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'timeline_event.dart';

part 'timeline_state.dart';

@Injectable()
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this._charactersUC) : super(const TimelineState()) {
    on<TimelineInitialized>(_onTimelineInitialized);
  }

  final CharactersUC _charactersUC;

  FutureOr<void> _onTimelineInitialized(TimelineInitialized event,
      Emitter<TimelineState> emit) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final data = await _charactersUC.getCharacters();
      data.sort((a, b) {
        if (a is PharaohEntity && b is PharaohEntity)
          return (b.date ).compareTo(a.date);
        else
          return 0;
      });
      emit(state.copyWith(
        status: PageStatus.success,
        characters: data,
      ));
    } catch (e) {
      emit(state.copyWith(status: PageStatus.error));
    }
  }
}
