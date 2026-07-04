import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  ThemeMode get themeMode =>
      isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  bool isFavorite(Map<String, dynamic> item) {
    return _favorites.any((fav) => fav['name'] == item['name']);
  }

  void toggleFavorite(Map<String, dynamic> item) {
    if (isFavorite(item)) {
      _favorites.removeWhere(
        (fav) => fav['name'] == item['name'],
      );
    } else {
      _favorites.add(item);
    }

    notifyListeners();
  }
}