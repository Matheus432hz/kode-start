import 'dart:convert';
import 'package:http/http.dart' as http;
import 'character_model.dart';

class ApiService {
  // A URL base da API do Rick and Morty
  final String baseUrl = "https://rickandmortyapi.com/api/";

  // Uma função que busca os personagens e retorna uma lista deles
  Future<List<Character>> getCharacters() async {
    // Faz a requisição para o endpoint de personagens
    final response = await http.get(Uri.parse('${baseUrl}character'));

    // Verifica se a requisição foi bem-sucedida (código 200)
    if (response.statusCode == 200) {
      // Decodifica a resposta JSON e pega a lista de 'results'
      List<dynamic> data = json.decode(response.body)['results'];
      // Transforma cada item da lista em um objeto Character
      List<Character> characters = data.map((item) => Character.fromJson(item)).toList();
      return characters;
    } else {
      // Se der erro, lança uma exceção
      throw Exception('Falha ao carregar os personagens');
    }
  }
}