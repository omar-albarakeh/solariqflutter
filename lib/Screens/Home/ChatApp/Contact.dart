import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'ChatScreen.dart';

class ContactsPage extends StatefulWidget {
  final String token;

  const ContactsPage({Key? key, required this.token}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late Future<List<dynamic>> contacts;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    contacts = ApiService().fetchContacts(widget.token);
  }

  void refreshContacts() {
    setState(() {
      contacts = ApiService().fetchContacts(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshContacts,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: const InputDecoration(
                hintText: "Search contacts",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 10),
                  Text(
                    "Error: ${snapshot.error}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: refreshContacts,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No contacts found",
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            final contactsList = snapshot.data!
                .where((contact) => contact['name']
                .toLowerCase()
                .contains(searchQuery))
                .toList();
            if (contactsList.isEmpty) {
              return const Center(
                child: Text(
                  "No contacts match your search",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          }
        },
      ),
    );
  }
}