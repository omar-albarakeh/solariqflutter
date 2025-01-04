class Messagemodel {
  final String type;
  final String message;
  final String time;

  Messagemodel({
    required this.type,
    required this.message,
    required this.time,
  });


  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'message': message,
      'time': time,
    };
  }

  factory Messagemodel.fromMap(Map<String, dynamic> map) {
    return Messagemodel(
      type: map['type'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
    );
  }
}
