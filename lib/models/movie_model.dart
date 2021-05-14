class Movie {
  final int id;
  final String image;
  final String title;
  final String director;
  final String cast;
  final String genre;
  final String description;
  final DateTime release;
  final double price;
  final String time;

  // Constructor data model
  const Movie._({
    this.id,
    this.image,
    this.title,
    this.director,
    this.cast,
    this.genre,
    this.description,
    this.release,
    this.price,
    this.time,
  });

  // Converting JSON to Movie Model
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie._(
        id: int.parse(json["movie_id"]),
        image: json["movie_image"],
        title: json["movie_title"],
        director: json["movie_director"],
        cast: json["movie_cast"],
        genre: json["movie_genre"],
        description: json["movie_description"],
        release: DateTime.tryParse("${json["movie_released"].toString()}"),
        price: double.parse(json["movie_price"]),
        time: json["movie_time"]);
  }

  Map<String, dynamic> toJson() => {
        "movie_id": id,
        "movie_image": image,
        "movie_title": title,
        "movie_director": director,
        "movie_cast": cast,
        "movie_genre": genre,
        "movie_description": description,
        "movie_released": release,
        "movie_price": price,
        "movie_time": time,
      };
}
