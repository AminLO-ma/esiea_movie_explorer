import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

//gestion ici de tout l'état global lié aux films
class MovieProvider extends ChangeNotifier {
  final MovieService _service = MovieService();

  List<Movie> _movies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // getters pour que les widgets puissent lire l'état sans le modifier directement
  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadPopularMovies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _movies = await _service.fetchPopularMovies();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    // si la recherche est vide on recharge les films populaires
    if (query.isEmpty) {
      loadPopularMovies();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _movies = await _service.searchMovies(query);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
