import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get Users
  Future getData() async {
    var users = firestore.collection('users');
    return users.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: getData(),
                builder: (BuildContext build, AsyncSnapshot snapShot) {
                  if (snapShot.hasData) {
                    return ListView.builder(
                      itemCount: snapShot.data.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 220, 212, 212),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              '${snapShot.data!.docs[index]['name']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                              '${snapShot.data!.docs[index]['email']}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
