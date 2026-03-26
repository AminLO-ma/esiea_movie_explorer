import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../main.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes favoris')),
      // ValueListenableBuilder écoute les changements de la liste des favoris
      body: ValueListenableBuilder<List<Movie>>(
        valueListenable: favoritesProvider.favorites,
        builder: (context, favorites, _) {
          if (favorites.isEmpty) {
            return const Center(child: Text('Aucun favori pour l\'instant'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final movie = favorites[index];
              return MovieCard(
                movie: movie,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
