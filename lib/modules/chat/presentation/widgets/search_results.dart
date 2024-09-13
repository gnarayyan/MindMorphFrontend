import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';

import '../../../auth/login/data/local_storage/user_storage.dart';
import '../../models/conversations_model.dart';
import '../../models/search_people_model.dart';
import '../screens/chat_screen.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.users,
  });

  final List<UserSearchResultModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final receiver = users[index];

        return Card(
          color: const Color.fromARGB(255, 7, 78, 133),
          child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  'http://$NODE_SERVER/${receiver.avatar}',
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
              ),
              title: Text(
                receiver.fullName,
                style: const TextStyle(
                    color: Color.fromARGB(255, 165, 195, 238), fontSize: 16),
              ),
              onTap: () async {
                final user = await UserStorage.user;
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          token: user.token,
                          receiver: Participant(
                              id: receiver.id,
                              fullName: receiver.fullName,
                              avatar: receiver.avatar),
                          conversationId: -1),
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
