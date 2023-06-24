import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_of_the_nile/index.dart';

class BaseBlocBuilder<T extends Bloc<dynamic, S>, S extends BaseState>
    extends StatelessWidget {
  const BaseBlocBuilder({
    super.key,
    required this.onSuccess,
  });

  final BlocWidgetBuilder<S> onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, S>(
      builder: (context, state) {
        switch (state.status) {
          case PageStatus.success:
            return onSuccess.call(context, state);

          case PageStatus.error:
            return const Center(
              child: Text(
                'An error occurred',
                textAlign: TextAlign.center,
              ),
            );

          case PageStatus.initial:
          case PageStatus.loading:
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
