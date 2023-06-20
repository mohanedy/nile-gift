import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/index.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {});
  }
}
