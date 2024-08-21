import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final String chatRoomId;
  final Map? userMap;
  ChatScreen({super.key, required this.chatRoomId, required this.userMap});

  //controllers
  TextEditingController message = TextEditingController();

  //firebase instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  onSendMessage() async {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": auth.currentUser?.displayName,
        "message": message.text,
        "time": FieldValue.serverTimestamp(),
      };
      message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print('Enter some text');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          userMap?['name'] ?? 'Chat',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff202c33),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: firestore
                  .collection('chatroom')
                  .doc(chatRoomId)
                  .collection('chats')
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> map =
                          snapshot.data!.docs[index].data();
                      return Align(
                        alignment:
                            map['sendBy'] == auth.currentUser?.displayName
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 13, left: 13),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 5),
                          decoration: BoxDecoration(
                            color:
                                map['sendBy'] == auth.currentUser?.displayName
                                    ? const Color(0xff005c4b)
                                    : const Color(0xff202c33),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            map['message'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: message,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff2a3942),
                      hintText: 'Enter message',
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 45, 52),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusColor:
                          Colors.white, // Color of the border when focused
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    onSendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
