// import 'package:flutter/cupertino.dart';
// import 'package:gift_of_the_nile/constants.dart';
// import 'package:gift_of_the_nile/models/ancient_gods_entity.dart';
// import 'package:gift_of_the_nile/models/charcter_entity.dart';
// import 'package:gift_of_the_nile/models/pharaohs_entity.dart';
// import 'package:gift_of_the_nile/services/data_service_provider.dart';
// import 'package:rxdart/rxdart.dart';
//
// class HomeScreenBloc {
//   final _ancientGods = BehaviorSubject<AncientGods>();
//   final _pharaohs = BehaviorSubject<Pharaohs>();
//   final _isLoading = BehaviorSubject<bool>();
//   final _isSearching = BehaviorSubject<bool>.seeded(false);
//   final _searchText = BehaviorSubject<String>();
//   final _searchResult = BehaviorSubject<List<Character>>();
//   DataServiceProvider _provider = DataServiceProvider();
//
//   ValueStream<AncientGods> get ancientGods => _ancientGods.stream;
//
//   ValueStream<Pharaohs> get pharaohs => _pharaohs.stream;
//
//   ValueStream<List<Character>> get searchResult => _searchResult.stream;
//
//   ValueStream<String> get searchText => _searchText.stream;
//
//   ValueStream<bool> get isLoading => _isLoading.stream;
//
//   ValueStream<bool> get isSearching => _isSearching.stream;
//
//   Function(bool) get onSearchingChange => _isSearching.sink.add;
//
//   Function(bool) get onLoadingChange => _isLoading.sink.add;
//   List<Character> characters = [];
//
//   void onSearchChange(String q) {
//     if (q != null || q.isNotEmpty) {
//       _searchResult.sink.add(characters.where((c) {
//         if (c.name.toLowerCase().contains(q.toLowerCase()))
//           return true;
//         else
//           return false;
//       }).toList());
//     }
//   }
//
//   HomeScreenBloc(BuildContext context) {
//     initData(context);
//   }
//
//   initData(BuildContext context) async {
//     _isLoading.sink.add(true);
//     _ancientGods.sink
//         .add(await _provider.loadData(context, CharacterType.EgyptianGod));
//     _pharaohs.sink
//         .add(await _provider.loadData(context, CharacterType.EgyptianPharaohs));
//     characters.addAll(_ancientGods.value.characters);
//     characters.addAll(_pharaohs.value.characters);
//
//     _isLoading.sink.add(false);
//   }
//
//   dispose() async {
//     await _ancientGods.drain();
//     _ancientGods.close();
//     await _isLoading.drain();
//     _isLoading.close();
//     await _pharaohs.drain();
//     _pharaohs.close();
//     await _isSearching.drain();
//     _isSearching.close();
//     await _searchText.drain();
//     _searchText.close();
//     await _searchResult.drain();
//     _searchResult.close();
//   }
// }
