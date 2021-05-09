class Schedule {
  final int schedId;
  final int movieId;
  final String movieTitle;
  final String date;
  final String timestart;
  final String timeend;

  // Singleton class
  const Schedule._({
    this.schedId,
    this.movieId,
    this.movieTitle,
    this.date,
    this.timestart,
    this.timeend,
  });

  // JSON Parse
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule._(
      schedId: int.parse(json["sched_id"]),
      movieId: int.parse(json["movie_id"]),
      movieTitle: json["movie_title"],
      date: json["sched_date"],
      timestart: json["sched_timestart"],
      timeend: json["sched_timeend"],
    );
  }

  Map<String, dynamic> toJson() => {
        "sched_id": schedId,
        "movie_id": movieId,
        "movie_title": movieTitle,
        "sched_date": date,
        "sched_timestart": timestart,
        "sched_timeend": timeend,
      };
}
