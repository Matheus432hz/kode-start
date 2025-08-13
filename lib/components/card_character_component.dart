import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CardCharacterComponent extends StatelessWidget {
  final void Function() onTap;
  final String characterName;
  final String characterImg;

  const CardCharacterComponent({
    super.key,
    required this.onTap,
    required this.characterName,
    required this.characterImg,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              characterImg,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 160,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  color: isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight,
                  child: Icon(Icons.error_outline, color: AppColors.red, size: 40),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                characterName.toUpperCase(),
                style: TextStyle(
                  color: isDarkMode ? AppColors.textColorDark : AppColors.textColorLight,
                  fontWeight: FontWeight.w900, // Equivalente a 'black' ou 'heavy'
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}