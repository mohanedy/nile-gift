import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:rxdart/rxdart.dart';

class BooksHomeBloc {
  final _provider = DataServiceProvider();
  final _loading = BehaviorSubject<bool>();
  final _booksList = BehaviorSubject<List<Book>>();

  Observable<bool> get showProgressBar => _loading.stream;

  Observable<List<Book>> get booksStream => _booksList.stream;

  BooksHomeBloc(BuildContext context) {
    _initData(context);
  }

  _initData(BuildContext context) async {
    _booksList.sink.add(await _provider.getBooks(context));
  }

  dispose() async {
    await _loading.drain();
    _loading.close();
    await _booksList.drain();
    _booksList.close();
  }
}
