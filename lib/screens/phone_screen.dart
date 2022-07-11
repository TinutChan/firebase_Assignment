import 'package:firebase_assignment/services/firebase_auth_methods.dart';
import 'package:firebase_assignment/widgets/custom_button_noImage.dart';
import 'package:firebase_assignment/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign in', style: TextStyle()),
            const Text('with your phone number'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            CustomTextField(
              controller: phoneController,
              hintText: 'Enter phone number',
            ),
            CustomButton02(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .phoneSignIn(context, phoneController.text);
              },
              text: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}
