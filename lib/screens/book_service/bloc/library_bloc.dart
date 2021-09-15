import 'dart:io';

import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/services/data_service_provider.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc {
  final _downloadedBooks = BehaviorSubject<List<Map<String, dynamic>>>();
  final _provider = DataServiceProvider();

  ValueStream<List<Map<String, dynamic>>> get downloadedBooks =>
      _downloadedBooks.stream;
  final List<Book> _books;

  LibraryBloc(this._books) {
    initData();
  }

  initData() async {
    _downloadedBooks.sink.add(await _provider.getDownloadedBooks(_books));
  }

  deleteBook(Book book, String path) async {
    final file = File(path);
    await _provider.deleteDownloadedBook(book);
    await file.delete();
    initData();
  }

  dispose() async {
    await _downloadedBooks.drain();
    _downloadedBooks.close();
  }
}
