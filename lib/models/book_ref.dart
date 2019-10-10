import 'package:gift_of_the_nile/models/gbook.dart';

class BookReference {
  List<Book> books;

  BookReference({this.books});

  factory BookReference.fromJson(Map<String, dynamic> json) {
    return BookReference(
      books: json['books'] != null
          ? (json['books'] as List).map((i) => Book.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Book {
  String downloadLink;
  String isbn;
  String id;
  Item bookResult;
  double bookSize;

  Book({this.downloadLink, this.isbn, this.bookResult, this.id, this.bookSize});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        downloadLink: json['download_link'],
        isbn: json['isbn'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['download_link'] = this.downloadLink;
    data['isbn'] = this.isbn;
    return data;
  }
}
