part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class HomeInitialized extends HomeEvent {
  const HomeInitialized();

  @override
  List<Object?> get props => [];
}
