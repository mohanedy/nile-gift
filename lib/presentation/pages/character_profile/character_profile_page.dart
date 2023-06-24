import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gift_of_the_nile/index.dart';

class CharacterProfilePage extends HookWidget {
  const CharacterProfilePage({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CharacterProfileBloc>(),
      child: Scaffold(
        body: CharacterProfileContent(
          character: character,
        ),
      ),
    );
  }
}
