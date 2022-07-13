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
        actions: [
          IconButton(
            onPressed: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
            icon: const Icon(Icons.output),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.photoURL != null)
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            const SizedBox(
              height: 15,
            ),
            if (user.displayName != null) Text('Name: ${user.displayName!}'),
            const SizedBox(height: 15),
            if (!user.isAnonymous && user.phoneNumber == null)
              Text('Email: ${user.email!}'),
            const SizedBox(
              height: 15,
            ),
            if (!user.isAnonymous && user.phoneNumber == null)
              Text('Provider: ${user.providerData[0].providerId}'),
            const SizedBox(
              height: 15,
            ),
            if (!user.emailVerified && !user.isAnonymous)
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
