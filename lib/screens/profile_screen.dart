import 'package:firebase_assignment/services/firebase_auth_methods.dart';
import 'package:firebase_assignment/widgets/custom_button_noImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!user.isAnonymous && user.phoneNumber == null)
              Text(user.email!),
            if (!user.isAnonymous && user.phoneNumber == null)
              Text(user.providerData[0].providerId),
            if (user.phoneNumber != null) Text(user.phoneNumber!),
            Text(user.uid),
            CustomButton02(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .sendEmailVerification(context);
              },
              text: 'Verify Email',
            ),
            CustomButton02(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              text: 'Sign Out',
            ),
            CustomButton02(
              onTap: () {
                context.read<FirebaseAuthMethods>().deleteAccount(context);
              },
              text: 'Delete Account',
            ),
          ],
        ),
      ),
    );
  }
}
