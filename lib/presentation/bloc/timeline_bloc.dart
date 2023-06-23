// import 'package:flutter/cupertino.dart';
// import 'package:gift_of_the_nile/constants.dart';
// import 'package:gift_of_the_nile/models/charcter_entity.dart';
// import 'package:gift_of_the_nile/services/data_service_provider.dart';
// import 'package:rxdart/rxdart.dart';
//
// class TimelineBloc {
//   final _charactersFiltered = BehaviorSubject<List<Character>>();
//   DataServiceProvider _provider = DataServiceProvider();
//
//   ValueStream<List<Character>> get characters => _charactersFiltered.stream;
//
//   TimelineBloc(BuildContext context) {
//     initData(context);
//   }
//
//   initData(BuildContext context) async {
//     List<Character> characters = [];
//     final ancientGods =
//         await _provider.loadData(context, CharacterType.EgyptianGod);
//     final pharaohs =
//         await _provider.loadData(context, CharacterType.EgyptianPharaohs);
//     characters.addAll(pharaohs.characters);
//     characters.addAll(ancientGods.characters);
//     characters.sort((c1, c2) {
//       return c2.date.compareTo(c1.date);
//     });
//     _charactersFiltered.sink.add(characters);
//   }
//
//   dispose() async {
//     await _charactersFiltered.drain();
//     _charactersFiltered.close();
//   }
// }
