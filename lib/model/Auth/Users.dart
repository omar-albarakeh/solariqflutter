class Users {
  final String name;
  final String email;
  final String password;
  final String type;
  final String phoneNumber;
  final String? address;
  late bool? hasFilledSolarInfo;

  Users({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.phoneNumber,
    this.address,
    this.hasFilledSolarInfo,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      type: json['type'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      hasFilledSolarInfo: json['hasFilledSolarInfo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'phoneNumber': phoneNumber,
      if (address != null) 'address': address,
      'hasFilledSolarInfo': hasFilledSolarInfo,
    };
  }
}
