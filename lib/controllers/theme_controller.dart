import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  // Variável privada para guardar o estado do tema
  bool _isDarkMode = true; // Começa com o tema escuro como padrão

  // "Getter" público para que outros possam ler o estado, mas não modificar diretamente
  bool get isDarkMode => _isDarkMode;

  // Método para trocar o tema
  void toggleTheme(bool isDark) {
    _isDarkMode = isDark;
    // Avisa a todos os "ouvintes" (widgets) que o estado mudou, para que eles se reconstruam
    notifyListeners();
  }
}