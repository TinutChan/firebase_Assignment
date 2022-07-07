import 'package:firebase_assignment/screens/home_screen.dart';
import 'package:firebase_assignment/screens/login_email_password_screen.dart';
import 'package:firebase_assignment/screens/phone_screen.dart';
import 'package:firebase_assignment/screens/signup_email_password_screen.dart';
import 'package:firebase_assignment/services/firebase_auth_methods.dart';
import 'package:firebase_assignment/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailPasswordSignup.routeName);
              },
              text: 'Email/Password Sign Up',
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, EmailPasswordLogin.routeName);
              },
              text: 'Email/Password Login',
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PhoneScreen.routeName);
                },
                text: 'Phone Sign In'),
            CustomButton(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .signInWithGoogle(context)
                    .then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                });
              },
              text: 'Google Sign In',
            ),
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signInWithFacebook(context);
              },
              text: 'Facebook Sign In',
            ),
          ],
        ),
      ),
    );
  }
}
