class Users {
  final String username;
  final String email;
  final String type;
  final String phoneNumber;
  final String? address;

  Users({
    required this.username,
    required this.email,
    required this.type,
    required this.phoneNumber,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      username: json['username'],
      email: json['email'],
      type: json['type'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}