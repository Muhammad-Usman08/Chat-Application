import 'package:chatapp/components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  Map? userMap;

  //controllers
  TextEditingController search = TextEditingController();

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
          ),
        );
      }
    });

    await firestore
        .collection('users')
        .where('email', isEqualTo: search.text)
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
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
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: 'Enter email for which you want to chat',
                        prefixIcon: const Icon(Icons.email)),
                  ),
                ),
                button('Search', 130, 40, () {
                  onSearch();
                }),
                userMap != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(userMap?['name']),
                          subtitle: Text(userMap?['email']),
                          trailing: const Icon(Icons.chat),
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
