// lib/components/app_bar_component.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/theme_controller.dart';
import '../theme/app_images.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;

  const AppBarComponent({
    super.key,
    this.isHomePage = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Usamos 'watch' para que o ícone mude quando o tema for trocado
    final themeController = context.watch<ThemeController>();

    return AppBar(
      centerTitle: true,
      leading: isHomePage ? null : const BackButton(),
      title: Image.asset(
        AppImages.logo,
        height: 40,
      ),
      // Ações que aparecem no lado direito da AppBar
      actions: [
        // Ícone de sol/lua
        Icon(themeController.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny),
        // Switch para ligar/desligar o modo escuro
        Switch(
          value: themeController.isDarkMode,
          onChanged: (value) {
            // Usamos 'read' aqui porque estamos dentro de uma função de callback
            // e não precisamos que este widget específico se reconstrua
            context.read<ThemeController>().toggleTheme(value);
          },
          activeColor: Colors.amber, // Cor da bolinha do switch
        ),
        const SizedBox(width: 8), // Um pequeno espaçamento
      ],
    );
  }
}