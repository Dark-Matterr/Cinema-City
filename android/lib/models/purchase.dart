class Purchase {
  final int ticketId;
  final String customerName;
  final String movieTitle;
  final List<String> seatNum;
  final DateTime schedDate;
  final double price;
  final DateTime dateTransact;

  const Purchase._({
    this.ticketId,
    this.customerName,
    this.movieTitle,
    this.seatNum,
    this.schedDate,
    this.price,
    this.dateTransact,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase._(
      ticketId: int.parse(json["ticket_id"]),
      customerName: json["customer_name"],
      movieTitle: json["movie_title"],
      seatNum: json["seat_num"].toString().split(","),
      schedDate: DateTime.tryParse(
          "${json['sched_date'].toString()} ${json['sched_timestart'].toString()}"),
      price: double.parse(json['price']),
      dateTransact: DateTime.tryParse("${json['date_transact']}"),
    );
  }
}
