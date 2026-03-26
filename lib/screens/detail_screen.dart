import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../main.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // affichage du poster en pleine largeur
            movie.fullPosterUrl.isNotEmpty
                ? Image.network(
                    movie.fullPosterUrl,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    height: 400,
                    child: Center(child: Icon(Icons.movie, size: 80)),
                  ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ValueListenableBuilder, se rebuild uniquement quand les favoris changent
                      ValueListenableBuilder<List<Movie>>(
                        valueListenable: favoritesProvider.favorites,
                        builder: (context, favorites, _) {
                          final isFav = favoritesProvider.isFavorite(movie);
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : null,
                            ),
                            onPressed: () =>
                                favoritesProvider.toggleFavorite(movie),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '⭐ ${movie.voteAverage.toStringAsFixed(1)} · ${movie.releaseDate}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    movie.overview,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
