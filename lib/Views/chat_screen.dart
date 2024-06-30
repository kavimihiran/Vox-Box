import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vox_box/Models/message.dart';
import 'package:vox_box/Utils/colors.dart';

class ChatScreen extends StatefulWidget {
  final String roomId;

  const ChatScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DatabaseReference _roomRef;
  late DatabaseReference _messagesRef;
  String _roomName = '';
  List<MessageModel> messages = [];
  User? currentUser;
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _roomRef = FirebaseDatabase(
      databaseURL:
          "https://voxbox-project-default-rtdb.asia-southeast1.firebasedatabase.app",
    ).ref().child('rooms').child(widget.roomId);
    _messagesRef = _roomRef.child('messages');
    _fetchRoomName();
    _fetchCurrentUser();
    _setupMessageListener();
  }

  Future<void> _fetchCurrentUser() async {
    currentUser = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  Future<void> _fetchRoomName() async {
    try {
      DataSnapshot snapshot = await _roomRef.child('roomName').get();
      if (snapshot.exists) {
        setState(() {
          _roomName = snapshot.value as String;
        });
      } else {
        setState(() {
          _roomName = 'Unknown Room';
        });
      }
    } catch (e) {
      setState(() {
        _roomName = 'Error loading room name';
      });
    }
  }

  void _setupMessageListener() {
    _messagesRef.onChildAdded.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        String text = data['messageContent'] ?? '';
        String userId = data['senderId'] ?? '';
        String userName = data['senderName'] ?? 'Unknown';
        DateTime createdAt = DateTime.parse(data['timestamp']);

        MessageModel message = MessageModel(
          messageId: snapshot.key!,
          senderId: userId,
          senderName: userName,
          messageContent: text,
          timestamp: createdAt,
        );

        setState(() {
          messages.insert(
              0, message); // Insert at the beginning for reverse order
        });
      }
    });
  }

  void _sendMessage() {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      MessageModel message = MessageModel(
        messageId: '',
        senderId: currentUser!.uid,
        senderName: currentUser!.displayName ?? 'Unknown',
        messageContent: messageText,
        timestamp: DateTime.now(),
      );
      _messagesRef.push().set({
        'senderId': message.senderId,
        'senderName': message.senderName,
        'messageContent': message.messageContent,
        'timestamp': message.timestamp.toIso8601String(),
      }).then((value) {
        _messageController.clear();
      }).catchError((error) {
        print('Failed to send message: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_roomName),
        centerTitle: true,
        backgroundColor: customColor,
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFE4E4E4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse:
                        true, // Reverse the list to show latest messages at the bottom
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      MessageModel message = messages[index];
                      bool isCurrentUser = message.senderId == currentUser!.uid;
                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? customColor : Colors.white,
                            borderRadius: isCurrentUser
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(0),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(12),
                                  ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isCurrentUser) // Display sender's name for other users' messages
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    message.senderName,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              Text(
                                message.messageContent,
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${message.timestamp.hour}:${message.timestamp.minute}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(
                                255, 218, 215, 215), // Use the specified color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: _sendMessage,
                        icon: Icon(Icons.send),
                        color: customColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
