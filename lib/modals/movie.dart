class Movie {
  int? id;
  final String name;
  final String genre;
  final String type;
  final String language;
  final String wood;
  final String rating;

  Movie({
    this.id,
    required this.name,
    required this.genre,
    required this.type,
    required this.language,
    required this.wood,
    required this.rating,
  });

  factory Movie.fromMap({required Map data}) {
    return Movie(
      id: data["id"],
      name: data["name"],
      genre: data["genre"],
      type: data["type"],
      language: data["language"],
      wood: data["wood"],
      rating: data["rating"],
    );
  }
}
