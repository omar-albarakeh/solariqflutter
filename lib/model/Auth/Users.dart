class Users {
  final String username;
  final String email;
  final String password;
  final String type;
  final String phoneNumber;
  final String? address;

  Users({
    required this.username,
    required this.email,
    required this.password,
    required this.type,
    required this.phoneNumber,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      type: json['type'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'type': type,
      'phoneNumber': phoneNumber,
      if (address != null) 'address': address,
    };
  }
}
