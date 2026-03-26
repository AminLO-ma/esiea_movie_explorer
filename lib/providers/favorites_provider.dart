import 'package:flutter/foundation.dart';
import '../models/movie.dart';

// ValueNatifier suffit ici
class FavoritesProvider {
  // n'importe quel widget peut écouter cette liste
  final ValueNotifier<List<Movie>> favorites = ValueNotifier([]);

  void toggleFavorite(Movie movie) {
    final current = List<Movie>.from(favorites.value);

    //si est déjà en favori on le retire, sinon on l'ajoute
    if (isFavorite(movie)) {
      current.removeWhere((m) => m.id == movie.id);
    } else {
      current.add(movie);
    }
    favorites.value = current;
  }

  bool isFavorite(Movie movie) {
    return favorites.value.any((m) => m.id == movie.id);
  }
}
