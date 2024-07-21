import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/auth/login/data/local_storage/user_storage.dart';
import 'package:mindmorph/modules/chat/presentation/screens/chat_screen.dart';
import 'package:mindmorph/widgets/error_page.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../data/repositories/conversation_repository.dart';
import '../../models/conversations_model.dart';
import '../widgets/load_search_result.dart';

class Userlist {
  String name;
  String time;
  String count;
  String profileImage;
  String title;
  String message;
  Userlist(this.name, this.count, this.profileImage, this.time, this.title,
      this.message);
}

// ignore: must_be_immutable
class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text(
          'Conversations',
          style: TextStyle(
              color: Color.fromARGB(255, 136, 127, 127),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 46, 75),
        onSearch: (value) => setState(() => searchQuery = value),
        searchBackgroundColor: const Color.fromARGB(255, 26, 56, 80),
        searchTextStyle: const TextStyle(color: Colors.white),
        openOverlayOnSearch: true,
      )

      //  AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => const SearchUserToChat(),
      //             ),
      //           );
      //         },
      //         icon: const Icon(Icons.search))
      //   ],
      //------------------------
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.notifications_active,
      //       color: Color.fromARGB(255, 165, 195, 238),
      //     ),
      //   )
      // ],

      //   backgroundColor: const Color.fromARGB(255, 10, 46, 75),
      //   title: const Text(
      //     "Chat",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   centerTitle: true,
      // )
      ,
      body: searchQuery != ''
          ? LoadSearchResult(receiverNameQuery: searchQuery)
          : FutureBuilder<List<ConversationModel>>(
              future: ConversationRepository.getConversations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const MindMorphLoadingIndicator();
                } else if (snapshot.hasError) {
                  return const ErrorPage(message: 'No Conversations Avilable');
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.isEmpty) {
                  return const ErrorPage(message: 'No Conversation Available');
                } else {
                  final conversations = snapshot.data!;

                  return ConversationList(conversations: conversations);
                }
              },
            ),
    );
  }
}

class ConversationList extends StatelessWidget {
  const ConversationList({
    super.key,
    required this.conversations,
  });

  final List<ConversationModel> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        final receiver = conversation.participants[0];

        return Card(
          color: const Color.fromARGB(255, 7, 78, 133),
          child: ListTile(
              leading: ClipOval(
                child: Image.network(
                  'http://$COURSE_SERVER/media/35/JPEG_20240711_165251_615767971781557682.jpg',
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    conversation.lastMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    conversation.lastMessageTime,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 237, 171, 4), fontSize: 12),
                  )
                ],
              ),
              onTap: () async {
                final user = await UserStorage.user;
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          token: user.token,
                          receiver: receiver,
                          conversationId: conversation.conversationId),
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
