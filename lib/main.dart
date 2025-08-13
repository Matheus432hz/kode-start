import 'package:flutter/material.dart';
import 'api_service.dart';
import 'character_model.dart';
import 'character_detail_screen.dart';
import 'components/card_character_component.dart'; // Importa o novo card
import 'components/app_bar_component.dart';       // Importa a nova AppBar
import 'theme/app_colors.dart';                   // Importa nossas cores

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      // Tema para o modo claro (Light Mode)
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.backgroundColorLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColorLight,
          foregroundColor: AppColors.textColorLight, // Cor dos ícones e texto da AppBar
          elevation: 0,
        ),
      ),
      // Tema para o modo escuro (Dark Mode)
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundColorDark,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColorDark,
          foregroundColor: AppColors.textColorDark, // Cor dos ícones e texto da AppBar
          elevation: 0,
        ),
      ),
      // Deixa o app escolher o tema baseado no sistema (se é modo escuro ou claro)
      themeMode: ThemeMode.system,
      home: CharacterListScreen(),
    );
  }
}

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = ApiService().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usando a nossa AppBar customizada
      appBar: const AppBarComponent(isHomePage: true),
      body: FutureBuilder<List<Character>>(
        future: futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Character character = snapshot.data![index];
                // USANDO O NOVO COMPONENTE DE CARD
                return CardCharacterComponent(
                  characterName: character.name,
                  characterImg: character.image,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(character: character),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("Nenhum personagem encontrado."));
          }
        },
      ),
    );
  }
}