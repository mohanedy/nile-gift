import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataServiceProvider {
  DataServiceProvider();

  Future<Map<String, dynamic>> loadJsonData(
      String path, BuildContext context) async {
    final data = await DefaultAssetBundle.of(context).loadString(path);
    return jsonDecode(data);
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
    List<String>? likesList = prefs.getStringList('likes');
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
    List<String>? likesList = prefs.getStringList('likes');
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
      for (String cuid in (prefs.getStringList('likes') ?? [])) {
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

  Future<AppCharacters?> loadData(
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
