import 'package:firebase_assignment/models/show_people.dart';
import 'package:firebase_assignment/pages/create_people_page.dart';
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
      body: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                height: 150,
                color: Colors.grey.shade200,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: ShowPeoplePage(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePeoplePage(),
            ),
          );
        },
      ),
    );
  }
}
