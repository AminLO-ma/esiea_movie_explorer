import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';

const String _apiKey = String.fromEnvironment('TMDB_API_KEY');

const String _baseUrl = "https://api.themoviedb.org/3";

class MovieService {
  // pour récupèrer les films populaires du moment
  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$_baseUrl/movie/popular?apiKey&language=fr-FR');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];
        //transformation de chaque élément JSON en objet Movie
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de charger les films : $e');
    }
  }

  // même idée que fetchPopularMovies(), juste l'URL qui change
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse(
      '$_baseUrl/search/movie?api_key=$_apiKey&language=fr-FR&query=${Uri.encodeComponent(query)}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Erreur serveur : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Impossible de rechercher les films : $e');
    }
  }
}
