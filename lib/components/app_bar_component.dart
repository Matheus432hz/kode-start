// lib/components/app_bar_component.dart
import 'package:flutter/material.dart';
import '../theme/app_images.dart';
import '../theme/app_colors.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final bool isHomePage;

  const AppBarComponent({
    super.key,
    this.isHomePage = false, // Por padrão, não é a home page
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      // A cor do fundo vem do tema que já definimos
      centerTitle: true,
      // Ícone de voltar automático (só aparece se não for a home page)
      // A cor dele já é definida pelo foregroundColor no tema
      leading: isHomePage ? null : BackButton(),
      title: Image.asset(
        AppImages.logo,
        height: 40, // Ajuste a altura conforme necessário
      ),
    );
  }
}