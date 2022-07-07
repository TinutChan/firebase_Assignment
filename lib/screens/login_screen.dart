import 'package:firebase_assignment/screens/phone_screen.dart';
import 'package:firebase_assignment/screens/signup_email_password_screen.dart';
import 'package:firebase_assignment/services/firebase_auth_methods.dart';
import 'package:firebase_assignment/widgets/custom_button.dart';
import 'package:firebase_assignment/widgets/custom_checkedbox.dart';
import 'package:firebase_assignment/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                const CustomCheckbox(),
                const SizedBox(
                  width: 7,
                ),
                const Text('Remember Me'),
                const Spacer(),
                GestureDetector(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  onTap: () {
                    // Get.to(
                    //const ForgotPassword(),
                    //);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: loginUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1,
                  width: 135,
                  color: Colors.grey,
                ),
                const Text('Or With'),
                Container(
                  height: 1,
                  width: 135,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, PhoneScreen.routeName);
                },
                text: 'Phone Sign In'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                CustomButton(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, EmailPasswordSignup.routeName);
                  //   },
                  //   text: 'Email/Password Sigup',
                  // ),
                  // CustomButton(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithGoogle(context);
                    ;
                  },
                  text: 'Google Sign In',
                ),
                CustomButton(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithFacebook(context);
                  },
                  text: 'Facebook Sign In',
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
