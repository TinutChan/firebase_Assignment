// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_assignment/models/people_model.dart';
import 'package:firebase_assignment/services/people_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePeoplePage extends StatefulWidget {
  const CreatePeoplePage({Key? key}) : super(key: key);

  @override
  State<CreatePeoplePage> createState() => _CreatePeoplePageState();
}

class _CreatePeoplePageState extends State<CreatePeoplePage> {
  final name = TextEditingController();
  final gender = TextEditingController();
  final age = TextEditingController();
  final numphone = TextEditingController();
  final address = TextEditingController();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        imageQuality: 100,
      );
      setState(() {
        imageFile = pickedFile;
      });
    } catch (e) {
      debugPrint('Image Picker error => $e');
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _onImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _onImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _buildLoading() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 70.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15.0),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Create People'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0, color: Colors.grey),
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageFile != null
                          ? Image.file(File(imageFile!.path)).image
                          : const NetworkImage(
                              'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: gender,
                decoration: const InputDecoration(
                  hintText: 'Gender',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: age,
                decoration: const InputDecoration(
                  hintText: 'Age',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: numphone,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                ),
              ),
              const SizedBox(height: 26.0),
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
              ),
              const SizedBox(height: 26.0),
              ElevatedButton.icon(
                onPressed: () async {
                  _buildLoading();
                  await Future.delayed(const Duration(seconds: 2));
                  String _photoUrl =
                      await PeopleService().uploadPhoto(File(imageFile!.path));
                  PeopleModel _people = PeopleModel(
                    name: name.text,
                    gender: gender.text,
                    age: age.text,
                    numphone: numphone.text,
                    address: address.text,
                    photo: _photoUrl,
                  );
                  await PeopleService().createPeople(_people);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
