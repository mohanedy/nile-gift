import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_of_the_nile/index.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => di()..add(HomeInitialized()),
      child: Scaffold(
        body: HomeContent(),
      ),
    );
  }
}




