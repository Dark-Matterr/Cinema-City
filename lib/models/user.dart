class User {
  final int userId;
  final String userEmail;
  final String userFname;
  final String userLname;

  // Creae Singleton constructor
  const User._({
    this.userId,
    this.userEmail,
    this.userFname,
    this.userLname,
  });

  // Parsing User JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User._(
      userId: int.parse(json["customer_id"]),
      userEmail: json["customer_email"],
      userFname: json["customer_fname"],
      userLname: json["customer_lname"],
    );
  }

  // Encode to JSON
  Map<String, dynamic> toJson() => {
        "customer_id": userId,
        "customer_email": userEmail,
        "customer_fname": userFname,
        "customer_lname": userLname,
      };
}
