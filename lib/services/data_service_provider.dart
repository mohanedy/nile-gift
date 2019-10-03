import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/models/gbook.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';
import 'package:http/http.dart' as http;

class DataServiceProvider {
  Future<Map> loadJsonData(String path, BuildContext context) async {
    final data = await DefaultAssetBundle.of(context).loadString(path);
    return jsonDecode(data);
  }

  Future<List<Book>> getBooks(BuildContext context) async {
    try {
      List<Book> books = [];
      final booksRef = BookReference.fromJson(
          await loadJsonData('resources/data/books_api.json', context));
      for (Book b in booksRef.books) {
        final response = await http.get(
            'https://www.googleapis.com/books/v1/volumes?q=${b.isbn}+isbn&key=AIzaSyD4xI678VBxw_SXMAzLE7naH54rR6L-ZSo');
        final data = json.decode(response.body);
        final gBook = GBookResult.fromJson(data);
        b.bookResult = gBook;
        books.add(b);
      }
      return books;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Stream getBook(String isbn) {
    return http
        .get(
            'https://www.googleapis.com/books/v1/volumes?q=$isbn+isbn&key=AIzaSyD4xI678VBxw_SXMAzLE7naH54rR6L-ZSo')
        .asStream();
  }

  Future<Characters> loadData(
      BuildContext context, CharacterType characterType) async {
    switch (characterType) {
      case CharacterType.EgyptianGod:
        return AncientGods.fromJson(
            await loadJsonData('resources/data/ancient_gods.json', context));
      case CharacterType.EgyptianPharaohs:
        return Pharaohs.fromJson(
            await loadJsonData('resources/data/pharaohs.json', context));
      default:
        return null;
    }
  }
}
