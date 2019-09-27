import 'package:rxdart/rxdart.dart';

class CharacterScreenBloc {
  final _barOffset = BehaviorSubject<double>();
  Observable<double> get barOffsetStream => _barOffset.stream;
  Function(double) get changeBarOffset => _barOffset.sink.add;
  dispose() async {
    await _barOffset.drain();
    _barOffset.close();
  }
}
