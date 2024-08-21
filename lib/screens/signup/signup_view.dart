// ignore_for_file: avoid_print
import 'package:chatapp/components/button.dart';
import 'package:chatapp/components/textField/textfield.dart';
import 'package:chatapp/screens/home/home_view.dart';
import 'package:chatapp/screens/login/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //firebase instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  //signUp
  signUp(context) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (credential.user != null) {
        credential.user?.updateProfile(displayName: nameController.text);
        await addData();
        // Navigate to HomeScreen
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    } finally {
      // Clear text controllers regardless of success or failure
      nameController.clear();
      emailController.clear();
      passwordController.clear();
    }
  }

  addData() async {
    try {
      await firestore.collection('users').doc(auth.currentUser?.uid).set({
        'name': nameController.text,
        'email': emailController.text,
      });
      print('User added');
    } catch (error) {
      print('Error adding user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffEC2578),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: Image.asset('assets/logo-2.png')),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 70),
                        child: const Text(
                          'Deliver Favourite Food',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: 350,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 70),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 20),
                          child: Textfield(
                            text: 'Name',
                            controller: nameController,
                            icon: const Icon(Icons.person),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Textfield(
                            text: 'Email',
                            controller: emailController,
                            icon: const Icon(Icons.email),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Textfield(
                            text: 'Password',
                            controller: passwordController,
                            icon: const Icon(Icons.lock),
                          ),
                        ),
                        Container(
                          child: button(
                            'Create Account',
                            350,
                            50,
                            () {
                              signUp(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  child: const Text(
                    'Already have an account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEC2578)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
