import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  
  bool _isDarkMode = true; // Começa com o tema escuro como padrão

  
  bool get isDarkMode => _isDarkMode;

  // Método para trocar o tema
  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    // Avisa a todos os (widgets) que o estado mudou, para que eles se reconstruam
    notifyListeners();
  }
}