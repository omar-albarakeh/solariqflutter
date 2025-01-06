import 'package:flutter/material.dart';
import 'package:solariqflutter/Screens/Home/Pages/Community/ComunityPost.dart';
import '../../../../Config/AppText.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, dynamic>> demoPosts = [
      {
        'userName': 'SolarExpert',
        'content': 'Installed a 5kW solar panel system on my roof last week. Already seeing savings on my energy bill!',
        'likes': 42,
        'type': 'Engineer',
      },
      {
        'userName': 'GreenEnthusiast',
        'content': 'Thinking about switching to solar energy. Any tips for selecting the best provider?',
        'likes': 30,
        'type': 'User',
      },
      {
        'userName': 'EcoWarrior',
        'content': 'Just finished my DIY solar power generator setup! Perfect for emergencies.',
        'likes': 18,
        'type': 'User',
      },
      {
        'userName': 'EnergySaver2025',
        'content': 'Can someone explain the difference between monocrystalline and polycrystalline solar panels?',
        'likes': 25,
        'type': 'Engineer',
      },
      {
        'userName': 'FutureIsSolar',
        'content': 'The government incentives for solar energy this year are amazing! Don’t miss out.',
        'likes': 50,
        'type': 'User',
      },
    ];

    Widget _buildPostCard(dynamic post) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person, size: 24, color: Colors.white),
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['userName'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            '2 hours ago',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (post['type'] == 'Engineer')
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Ask an Engineer button clicked for ${post['userName']}')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: const Icon(Icons.engineering, color: Colors.white, size: 18),
                      label: const Text(
                        'Ask an Eng',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                post['content'],
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.blue),
                      ),
                      Text('${post['likes']} Likes'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                    },
                    child: const Text('Comments', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'Community',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: demoPosts.length,
        itemBuilder: (context, index) => _buildPostCard(demoPosts[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CommunityPost(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
