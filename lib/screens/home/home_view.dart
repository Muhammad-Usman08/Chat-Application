import 'package:chatapp/components/button.dart';
import 'package:chatapp/screens/chatRoom/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  Map? userMap;

  //controllers
  TextEditingController search = TextEditingController();

  //chat Room id
  String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().compareTo(user2.toLowerCase()) > 0) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  //search function
  onSearch() async {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (userMap == null) {
        setState(() {
          isLoading = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
          ),
        );
      }
    });

    await firestore
        .collection('users')
        .where('name', isEqualTo: search.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = false;
        });
      } else {
        setState(() {
          userMap = null;
        });
      }
    });
    search.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff202c33),
        automaticallyImplyLeading: false,
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 23),
                      border: InputBorder.none,
                      fillColor: Colors.grey[400],
                      filled: true,
                      hintText: 'Enter Name',
                      hintStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                button('Search', 130, 40, () {
                  onSearch();
                }),
                userMap != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ListTile(
                          onTap: () {
                            String roomId = chatRoomId(
                                auth.currentUser?.displayName ?? '',
                                userMap?['name']);

                            if (roomId.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    chatRoomId: roomId,
                                    userMap: userMap,
                                  ),
                                ),
                              );
                            }
                          },
                          leading: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          title: Text(userMap?['name'],
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            userMap?['email'],
                            style: const TextStyle(color: Colors.white54),
                          ),
                          trailing: const Icon(
                            Icons.chat,
                            color: Color(0xff005c4b),
                          ),
                          tileColor: Colors.black,
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
