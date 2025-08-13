import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return AppBar(
      elevation: 0,
      leading: isHomePage
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                print("Botão de menu clicado!");
              },
            )
          : const BackButton(),
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo,
              height: 60,
            ),
            const SizedBox(height: 6),
            Text(
              "RICK AND MORTY API",
              style: GoogleFonts.lato(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontSize: 14.5,
                fontWeight: FontWeight.w400, 
                letterSpacing: 14.5 * 0.165, 
                height: 1.0, 
              ),
            ),
          ],
        ),
      ),
      actions: [
        Switch(
          value: themeController.isDarkMode,
          onChanged: (value) {
            context.read<ThemeController>().toggleTheme(value);
          },
          activeColor: Colors.amber,
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {
            print("Botão de usuário clicado!");
          },
        ),
      ],
    );
  }
}