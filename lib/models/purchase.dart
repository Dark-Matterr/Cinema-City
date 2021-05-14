class Purchase {
  final int ticketId;
  final String movieTitle;
  final List<String> seatNum;
  final DateTime schedDate;
  final double price;

  const Purchase._({
    this.ticketId,
    this.movieTitle,
    this.seatNum,
    this.schedDate,
    this.price,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase._(
      ticketId: int.parse(json["ticket_id"]),
      movieTitle: json["movie_title"],
      seatNum: json["seat_num"].toString().split(","),
      schedDate: DateTime.tryParse(
          "${json['sched_date'].toString()} ${json['sched_timestart'].toString()}"),
      price: double.parse(json['price']),
    );
  }
}
