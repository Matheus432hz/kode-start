import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character_model.dart';

class ApiService {
  final String baseUrl = "https://rickandmortyapi.com/api/";

    Future<List<Character>> getCharacters() async {
    final response = await http.get(Uri.parse('${baseUrl}character'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      List<Character> characters = data.map((item) => Character.fromJson(item)).toList();
      return characters;
    } else {
      throw Exception('Falha ao carregar os personagens');
    }
  }
}