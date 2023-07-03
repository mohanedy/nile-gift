import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gift_of_the_nile/index.dart';
import 'package:injectable/injectable.dart';

part 'character_profile_event.dart';

part 'character_profile_state.dart';

@Injectable()
class CharacterProfileBloc
    extends Bloc<CharacterProfileEvent, CharacterProfileState> {
  CharacterProfileBloc({
    required this.toggleFavoriteUC,
  }) : super(const CharacterProfileState()) {
    on<CharacterFavoritesTriggered>(_onCharacterFavoritesTriggered);
  }

  final ToggleFavoriteUC toggleFavoriteUC;

  FutureOr<void> _onCharacterFavoritesTriggered(
    CharacterFavoritesTriggered event,
    Emitter<CharacterProfileState> emit,
  ) async {
    await toggleFavoriteUC(event.character);
  }
}
