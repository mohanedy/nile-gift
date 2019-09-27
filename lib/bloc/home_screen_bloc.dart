import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  final _ancientGods = BehaviorSubject<AncientGods>();
  final _isLoading = BehaviorSubject<bool>();
  DataServiceProvider _provider = DataServiceProvider();

  Observable<AncientGods> get ancientGods => _ancientGods.stream;

  Observable<bool> get isLoading => _isLoading.stream;

  Function(bool) get onLoadingChange => _isLoading.sink.add;

  HomeScreenBloc(BuildContext context) {
    initData(context);
  }

  initData(BuildContext context) async {
    _isLoading.sink.add(true);
    _ancientGods.sink.add(await _provider.loadData(context));
    _isLoading.sink.add(false);
  }

  dispose() async {
    await _ancientGods.drain();
    _ancientGods.close();
    await _isLoading.drain();
    _isLoading.close();
  }
}
