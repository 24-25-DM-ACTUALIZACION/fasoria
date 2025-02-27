import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

///FetchData permite hacer una peticion a la api freetogame
class FetchData {
  ///Método que obtiene una lista de juegos indi de la api https://www.freetogame.com
  ///
  ///Parámetros:
  ///- string getSearch
  ///
  ///Devuelve:
  ///- Lista dinamica de juegos
  static Future<List<dynamic>> getGames(String getSearch) async {
    final String baseUrl = 'https://www.freetogame.com/api/';
    final url = Uri.parse('$baseUrl$getSearch'); // Construye la URL completa

    final headers = {
      'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      'Custom-Header': 'CustomHeaderValue',
      'Access-Control-Allow-Origin': '*',
    };
    try {
      // Realiza la solicitud GET
      final response = await http.get(url, headers: headers);

      // Comprueba el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON en una lista dinámica
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        // Manejo de errores si el código de estado no es 200
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      // Manejo de excepciones
      print('Excepción al realizar la solicitud: $e');
      return [];
    }
  }

  ///Método que obtiene una lista de juegos indi de un archivo json en la app
  ///
  ///Devuelve:
  ///- Lista dinamica de juegos
  static Future<List<dynamic>> getGamesLocal() async {
    final String response = await rootBundle.loadString('assets/documents/indi_games.json');
    final data = json.decode(response);
    return data;
  }
}

/* FetchData fetch = FetchData();
final Future<List> data = fetch.fetch('games'); */
