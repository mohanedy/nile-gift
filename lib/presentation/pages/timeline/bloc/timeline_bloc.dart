import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

part 'timeline_event.dart';

part 'timeline_state.dart';

@Injectable()
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this._getCharactersUC) : super(const TimelineState()) {
    on<TimelineInitialized>(_onTimelineInitialized);
  }

  final GetCharactersUC _getCharactersUC;

  FutureOr<void> _onTimelineInitialized(
    TimelineInitialized event,
    Emitter<TimelineState> emit,
  ) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final data = await _getCharactersUC(const NoParams());
      data.sort((a, b) {
        if (a is PharaohEntity && b is PharaohEntity) {
          return (b.date).compareTo(a.date);
        } else {
          return 0;
        }
      });
      emit(
        state.copyWith(
          status: PageStatus.success,
          characters: data,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PageStatus.error));
    }
  }
}
