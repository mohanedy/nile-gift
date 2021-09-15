import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:gift_of_the_nile/constants.dart';
import 'package:gift_of_the_nile/models/ancient_gods.dart';
import 'package:gift_of_the_nile/models/book_ref.dart';
import 'package:gift_of_the_nile/models/charcter.dart';
import 'package:gift_of_the_nile/models/gbook.dart';
import 'package:gift_of_the_nile/models/pharaoh.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataServiceProvider {
  final _dio = Dio();

  DataServiceProvider() {
    _dio.interceptors.add(
        DioCacheManager(CacheConfig(baseUrl: "https://www.googleapis.com"))
            .interceptor);
  }

  Future<Map> loadJsonData(String path, BuildContext context) async {
    final data = await DefaultAssetBundle.of(context).loadString(path);
    return jsonDecode(data);
  }

  Future<List<Book>> getBooks(BuildContext context) async {
    try {
      final booksRef = BookReference.fromJson(
          await loadJsonData('resources/data/books_api.json', context));
      List<Response> responses = await Future.wait(booksRef.books.map((b) {
        return _dio.get('https://www.googleapis.com/books/v1/volumes/${b.id}',
            options: buildCacheOptions(Duration(days: 7)));
      }));

      print('responses' + responses.length.toString());
      int index = 0;
      return responses.map((response) {
        final gBook = Item.fromJson(response.data);
        booksRef.books[index].bookResult = gBook;
        return booksRef.books[index++];
      }).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<GBookResult> getBook(String isbn) async {
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$isbn+isbn&key=AIzaSyD4xI678VBxw_SXMAzLE7naH54rR6L-ZSo'));
    final data = json.decode(response.body);
    final gBook = GBookResult.fromJson(data);
    return gBook;
  }

  Future<void> saveDownloadedBook(Book book, String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(book.id, path);
  }

  Future<void> deleteDownloadedBook(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(book.id);
  }

  Future<String> isDownloadedBook(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final bookPath = prefs.getString(book.id);
    return bookPath;
  }

  Future<List<Map<String, dynamic>>> getDownloadedBooks(
      List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> downloaded = [];
    for (String key in prefs.getKeys()) {
      if (key == 'likes') continue;
      final book = books.firstWhere((b) => b.id == key);

      downloaded.add({"book": book, 'path': prefs.getString(key)});
    }
    return downloaded;
  }

  Future<bool> isLiked(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    final likesList = prefs.getStringList('likes');
    if (likesList == null || likesList.isEmpty) {
      return false;
    } else {
      if (likesList.contains(character.name + '_' + character.id.toString())) {
        return true;
      }
    }
    return false;
  }

  Future<void> likeCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likesList = prefs.getStringList('likes');
    final cuid = character.name + '_' + character.id.toString();
    if (likesList == null || likesList.isEmpty) {
      likesList = [];
      likesList.add(cuid);
    } else {
      likesList.add(cuid);
    }
    await prefs.setStringList('likes', likesList);
  }

  Future<void> unlikeCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> likesList = prefs.getStringList('likes');
    final cuid = character.name + '_' + character.id.toString();
    if (likesList == null || likesList.isEmpty) {
      likesList = [];
    } else {
      likesList.remove(cuid);
    }
    await prefs.setStringList('likes', likesList);
  }

  Future<List<Character>> getLikedCharacters(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<Character> characters = [];
      characters.addAll(AncientGods.fromJson(
              await loadJsonData('resources/data/ancient_gods.json', context))
          .characters);
      characters.addAll(Pharaohs.fromJson(
              await loadJsonData('resources/data/pharaohs.json', context))
          .characters);
      List<Character> likedCharacters = [];
      for (String cuid in prefs.getStringList('likes')) {
        likedCharacters.add(characters.firstWhere((chara) {
          final name = cuid.split('_')[0];
          final id = cuid.split('_')[1];
          if (chara.name == name && chara.id == int.parse(id)) {
            return true;
          }
          return false;
        }));
      }
      return likedCharacters;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<AppCharacters> loadData(
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
