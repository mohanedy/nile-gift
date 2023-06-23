import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:gift_of_the_nile/presentation/pages/timeline/bloc/timeline_bloc.dart';
import 'package:gift_of_the_nile/presentation/pages/timeline/widgets/timeline_content.dart';

class TimelinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimelineBloc>(
      create: (context) => di()..add(TimelineInitialized()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Timeline',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.amber,
            ),
          ),
        ),
        body: TimelineContent(),
      ),
    );
  }
}
