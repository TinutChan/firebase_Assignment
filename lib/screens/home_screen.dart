import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Container(color: Colors.grey),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
    );
  }
}
