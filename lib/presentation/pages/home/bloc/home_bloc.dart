import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';

part 'home_state.dart';

@Injectable()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getCharactersUC,
  ) : super(const HomeState()) {
    on<HomeInitialized>(_onHomeInitialized);
  }

  final GetCharactersUC _getCharactersUC;

  FutureOr<void> _onHomeInitialized(
      HomeInitialized event, Emitter<HomeState> emit,) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final characters = await _getCharactersUC(const NoParams());
      emit(state.copyWith(status: PageStatus.success, characters: characters));
    } catch (e) {
      emit(state.copyWith(status: PageStatus.error));
    }
  }
}
