import 'package:json_annotation/json_annotation.dart';

// ce fichier est généré automatiquement par build_runner
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  final String title;
  final String overview;
  // mapping json : snake case --> Dart : camel case
  @JsonKey(name: 'poster_path', defaultValue: '')
  final String posterPath;

  @JsonKey(name: 'vote_average', defaultValue: 0.0)
  final double voteAverage;

  @JsonKey(name: 'release_date', defaultValue: '')
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  // fromJson et toJson sont générés automatiquement dans movie.g.dart
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  // l'API donne juste le chemin, je reconstruit l'URL complète ici
  String get fullPosterUrl {
    if (posterPath.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
