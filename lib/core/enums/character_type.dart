import 'package:flutter/material.dart';

enum CharacterType {
  ancientGod,
  pharaoh;

  const CharacterType();

  Color get characterColor {
    switch (this) {
      case CharacterType.pharaoh:
        return Colors.yellow.shade800;
      case CharacterType.ancientGod:
        return Colors.lightBlue.shade700;
      default:
        return Colors.lightBlue;
    }
  }

  String get stringName {
    switch (this) {
      case CharacterType.pharaoh:
        return 'Pharaoh';
      case CharacterType.ancientGod:
        return 'Ancient God';
      default:
        return '';
    }
  }
}
