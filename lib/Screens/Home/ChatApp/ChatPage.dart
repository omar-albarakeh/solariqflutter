import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solariqflutter/Config/AppText.dart';

import '../../../Config/AppColor.dart';
import '../../../Widgets/Common/Message/ChatCard.dart';
import 'Contact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp", style: AppTextStyles.appBarTitle),
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: Stack(children: [
        ChatCard(),
        Positioned(
          bottom: 320,
          right: 20,
          child: _AddContacts(context),
        ),
      ]),
    );
  }
}

Widget _AddContacts(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactsPage(token: '',)),
      );
    },
    backgroundColor: AppColor.primary,
    child: FaIcon(FontAwesomeIcons.plus),
  );
}