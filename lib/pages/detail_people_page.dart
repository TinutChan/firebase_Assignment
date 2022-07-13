import 'dart:io';
import 'package:firebase_assignment/models/people_model.dart';
import 'package:firebase_assignment/services/people_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailPeoplePage extends StatefulWidget {
  const DetailPeoplePage({
    Key? key,
    required this.people,
  }) : super(key: key);

  final PeopleModel people;

  @override
  State<DetailPeoplePage> createState() => _DetailPeoplePageState();
}

class _DetailPeoplePageState extends State<DetailPeoplePage> {
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  late TextEditingController name;
  late TextEditingController gender;
  late TextEditingController age;
  late TextEditingController numphone;
  late TextEditingController address;

  Future<void> _onImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        imageQuality: 100,
      );
      setState(() => imageFile = pickedFile);
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
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.people.name);
    gender = TextEditingController(text: widget.people.gender);
    age = TextEditingController(text: widget.people.age);
    numphone = TextEditingController(text: widget.people.numphone);
    address = TextEditingController(text: widget.people.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Create People'),
        actions: [
          IconButton(
            onPressed: () {
              PeopleService().deletePeople(widget.people.id!);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 15.0),
        ],
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellow,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageFile != null
                          ? Image.file(
                              File(imageFile!.path),
                            ).image
                          : NetworkImage(
                              widget.people.photo ??
                                  'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                            ),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(0.5, 0.5),
                        spreadRadius: 3,
                        color: Colors.white,
                      ),
                    ],
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  shadowColor: Colors.white,
                  onPrimary: Colors.white,
                  animationDuration: Duration(microseconds: 1),
                  primary: Colors.blue.shade900,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () async {
                  _buildLoading();
                  await Future.delayed(const Duration(seconds: 2));
                  if (imageFile == null) {
                    var peopleModel = PeopleModel(
                      id: widget.people.id,
                      name: name.text,
                      gender: gender.text,
                      age: age.text,
                      numphone: numphone.text,
                      address: address.text,
                      photo: widget.people.photo,
                    );
                    await PeopleService().updatePeople(peopleModel);
                  } else {
                    String? _photoUrl = await PeopleService()
                        .uploadPhoto(File(imageFile!.path));
                    var peopleModel = PeopleModel(
                      id: widget.people.id,
                      name: name.text,
                      gender: gender.text,
                      age: age.text,
                      numphone: numphone.text,
                      address: address.text,
                      photo: _photoUrl,
                    );
                    await PeopleService().updatePeople(peopleModel);
                  }

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
