import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:rxdart/rxdart.dart';

class CharacterScreenBloc {
  final _barOffset = BehaviorSubject<double>();
  final _isLiked = BehaviorSubject<bool>();
  final _provider = DataServiceProvider();

  Observable<double> get barOffsetStream => _barOffset.stream;
  Observable<bool> get isLiked => _isLiked.stream;
  Function(double) get changeBarOffset => _barOffset.sink.add;
  final Character _character;
  CharacterScreenBloc(this._character) {
    _initData();
  }

  _initData() async {
    _isLiked.sink.add(await _provider.isLiked(_character));
  }

  likeUnlikeCharacter() async {
    _isLiked.sink.add(await _provider.isLiked(_character));
    if (_isLiked.value == true) {
      _provider.unlikeCharacter(_character);
    } else {
      _provider.likeCharacter(_character);
    }
    _isLiked.sink.add(await _provider.isLiked(_character));
  }

  dispose() async {
    await _barOffset.drain();
    _barOffset.close();
    await _isLiked.drain();
    _isLiked.close();
  }
}
