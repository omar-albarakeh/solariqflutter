class MessageModel{

  String message;
  String time;
  String type;

  MessageModel({required this.message, required this.time, required this.type});


  Map<String,dynamic> toJson(){
    return {
      "type": this.type,
      "message": this.message,
      "time": this.time,
    };
  }

  factory  MessageModel.fromJson(Map<String,dynamic> json){
    return  MessageModel(
    type : json["type"],
    message : json["message"],
    time : json["time"],
    );
  }

}