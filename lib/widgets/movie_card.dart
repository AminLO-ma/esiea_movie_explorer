import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../main.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
            // petit poster
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: movie.fullPosterUrl.isNotEmpty
                  ? Image.network(
                      movie.fullPosterUrl,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(
                      width: 80,
                      height: 120,
                      child: Icon(Icons.movie),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '⭐ ${movie.voteAverage.toStringAsFixed(1)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.releaseDate,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            // icône favori qui se rebuild seule sans rebuild toute la liste
            ValueListenableBuilder<List<Movie>>(
              valueListenable: favoritesProvider.favorites,
              builder: (context, favorites, _) {
                final isFav = favoritesProvider.isFavorite(movie);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                  onPressed: () => favoritesProvider.toggleFavorite(movie),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
