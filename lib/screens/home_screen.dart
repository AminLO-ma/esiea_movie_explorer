import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/error_message.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // état local
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // chargement des films populaires dès que l'écran s'ouvre
    Future.microtask(() => context.read<MovieProvider>().loadPopularMovies());
  }

  @override
  void dispose() {
    // je libère le controller quand l'écran est détruit
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Explorer'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher un film...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              // setState local pour mettre à jour l'UI du champ, provider pour la recherche
              onChanged: (value) {
                setState(() {});
                context.read<MovieProvider>().searchMovies(value);
              },
            ),
          ),
        ),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(MovieProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage.isNotEmpty) {
      return ErrorMessage(message: provider.errorMessage);
    }

    if (provider.movies.isEmpty) {
      return const Center(child: Text('Aucun film trouvé'));
    }

    return ListView.builder(
      itemCount: provider.movies.length,
      itemBuilder: (context, index) {
        final movie = provider.movies[index];
        return MovieCard(
          movie: movie,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
          ),
        );
      },
    );
  }
}
