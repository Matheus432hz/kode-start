import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'character_model.dart';
import 'character_detail_screen.dart';
import 'components/card_character_component.dart';
import 'components/app_bar_component.dart';
import 'controllers/theme_controller.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    // ThemeController para todo o app
    ChangeNotifierProvider(
      create: (context) => ThemeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // "Ouve" as mudanças no ThemeController
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.backgroundColorLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColorLight,
          foregroundColor: AppColors.textColorLight,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundColorDark,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColorDark,
          foregroundColor: AppColors.textColorDark,
          elevation: 0,
        ),
      ),
      // O tema agora é controlado pelo controller
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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