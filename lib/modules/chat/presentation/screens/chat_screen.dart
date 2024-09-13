import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_client;

import '../../data/repositories/conversation_repository.dart';
import '../../models/conversations_model.dart';
import '../../models/messages_model.dart';

class ChatScreen extends StatefulWidget {
  final String token;
  final Participant receiver;
  final int conversationId;

  const ChatScreen(
      {super.key,
      required this.token,
      required this.receiver,
      required this.conversationId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late socket_client.Socket socket;
  final TextEditingController _controller = TextEditingController();
  final List<StatelessWidget> _messages = [];
  bool isPreviousMessagesLoading = true;

  void _loadPreviousMessages() async {
    final oldMessages =
        await ConversationRepository.getMessages(widget.conversationId);
    for (MessageModel message in oldMessages) {
      if (message.receiverId != widget.receiver.id) {
        setState(() {
          _messages.add(ReceiverMessageCard(messageReceived: message.message));
        });
      } else {
        setState(() {
          _messages.add(SenderMessageCard(message: message.message));
        });
      }
    }

    setState(() {
      isPreviousMessagesLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // Load messages only if 'conversationId>0'
    // TODO: Assume search users don't have already conversation start
    if (widget.conversationId > 0) {
      _loadPreviousMessages();
    } else {
      // Stop loader
      isPreviousMessagesLoading = false;
    }
    final String url = 'http://$NODE_SERVER/?token=${widget.token}';

    socket = socket_client.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    try {
      socket.connect();

      socket.on('connect', (_) {
        print('connected: ${socket.id}');
      });
//msg
      socket.on('receive-message', (msg) {
        final messageReceived = msg["message"];
        final messageBox =
            ReceiverMessageCard(messageReceived: messageReceived);
        setState(() {
          _messages.add(messageBox);
        });
      });

      socket.on('disconnect', (_) {
        print('disconnected');
      });
    } catch (e) {
      print('Error Due to : $e');
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String message = _controller.text.trim();
      final sendData = {'receiverId': widget.receiver.id, 'message': message};
      final jsonData = jsonEncode(sendData);
      setState(() {
        final messageBox = SenderMessageCard(message: message);
        _messages.add(messageBox); // Add the message to the list before sending
      });
      print('Message Sent: $jsonData');
      socket.emit('send-message', jsonData);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiver.fullName),
      ),
      body: isPreviousMessagesLoading
          ? const MindMorphLoadingIndicator()
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    shrinkWrap: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: _messages[index],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 2,
                          style: const TextStyle(color: Colors.black),
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'Enter message ',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
    // }
    // },
    // ));
  }
}

class ReceiverMessageCard extends StatelessWidget {
  const ReceiverMessageCard({
    super.key,
    required this.messageReceived,
  });

  final String messageReceived;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Text(
          messageReceived,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}
