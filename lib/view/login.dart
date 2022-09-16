import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountController.addListener(() {});
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fontColor = TextStyle(color: Colors.black);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/travel_logo.png',
              scale: 1.0,
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextField(
                controller: _accountController,
                autofocus: false,
                cursorColor: Colors.black,
                style: fontColor,
              ),
            ),
            Container(
              width: 200,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                style: fontColor,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                signIn();
              },
              child: const Icon(
                Icons.login,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: ((context) => Center(
            child: CircularProgressIndicator(),
          )),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _accountController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.email}");
    }
    Navigator.pop(context, '/');
  }
}
