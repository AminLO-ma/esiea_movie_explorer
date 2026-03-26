# Movie Explorer

Application Flutter d'exploration de films, construite avec l'API TMDB.

## Fonctionnalités

- Liste des films populaires du moment
- Recherche de films en temps réel
- Ajout et suppression de films en favoris
- Affichage du détail d'un film (poster, note, synopsis)

## Stack technique

- Flutter / Dart
- API REST TMDB (The Movie Database)
- `http` pour les appels réseau
- `provider` pour le state management global
- `json_serializable` pour le parsing JSON

## State Management

| Mécanisme | Utilisation |
|---|---|
| `setState` | Etat local —> champ de recherche dans HomeScreen |
| `ValueNotifier` | Etat global léger —> liste des favoris |
| `ChangeNotifier` + Provider | Etat global complexe —> films, loading, erreur |

## Structure du projet

```
lib/
├── main.dart
├── models/        # Movie + fichier généré movie.g.dart
├── services/      # Appels API TMDB
├── providers/     # MovieProvider et FavoritesProvider
├── screens/       # HomeScreen, DetailScreen, FavoritesScreen
└── widgets/       # MovieCard, ErrorMessage
```

## Lancer le projet

1. Cloner le repo
2. Lancer avec :
```bash
flutter pub get
flutter run --dart-define=TMDB_API_KEY="Api Key"
```

## Auteur

El Ouahbi Mohamed-Amine

