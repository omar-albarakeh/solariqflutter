import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';

class Chatcard extends StatefulWidget {
  const Chatcard({super.key});

  @override
  State<Chatcard> createState() => _ChatcardState();
}

class _ChatcardState extends State<Chatcard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        leading: CircleAvatar(
          radius: 25,
        ),
        title: Text("USERNAME",style: TextStyle(color: Colors.black),),
        trailing: Text("18:04"),
      )
    );
  }
}
