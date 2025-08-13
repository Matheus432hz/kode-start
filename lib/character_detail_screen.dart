import 'package:flutter/material.dart';
import 'character_model.dart';
import 'components/app_bar_component.dart'; // Importa a nova AppBar
import 'theme/app_colors.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailScreen({super.key, required this.character});

  // Função para pegar a cor do status
  Color getStatusColor(String status) {
    if (status == 'Alive') return AppColors.green;
    if (status == 'Dead') return AppColors.red;
    return AppColors.gray;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColors.textColorDark : AppColors.textColorLight;

    return Scaffold(
      // Usando a AppBar customizada (sem o isHomePage, para mostrar o botão de voltar)
      appBar: const AppBarComponent(),
      body: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(16),
          color: isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do personagem
              Image.network(
                character.image,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 300, // Um pouco maior para mais destaque
              ),
              // Padding para as informações
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do personagem
                    Text(
                      character.name.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24, // Maior para destaque
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Status ( bola colorida)
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: getStatusColor(character.status),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${character.status} - ${character.species}',
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Mais espaço
                    // Outras informações
                    _buildInfoRow('Gênero:', character.gender, textColor),
                    _buildInfoRow('Origem:', character.originName, textColor),
                    _buildInfoRow('Última localização:', character.locationName, textColor),
                    // Como a API não nos dá o nome, exibimos a URL do episódio
                    _buildInfoRow('Primeira aparição (Episódio):', character.firstSeen.split('/').last, textColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar as linhas de informação de forma organizada
  Widget _buildInfoRow(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}