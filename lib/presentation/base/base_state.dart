import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/presentation/index.dart';

base class BaseState extends Equatable {
  const BaseState({
    this.status = PageStatus.initial,
  });

  final PageStatus status;

  @override
  List<Object?> get props => [
        status,
      ];
}
