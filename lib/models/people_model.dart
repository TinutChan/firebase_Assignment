import 'package:cloud_firestore/cloud_firestore.dart';

class PeopleModel {
  String? id;
  String? name;
  String? gender;
  String? age;
  String? numphone;
  String? address;
  String? photo;

  PeopleModel({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.numphone,
    this.address,
    this.photo,
  });

  PeopleModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    name = doc['name'];
    gender = doc['gender'];
    age = doc['age'];
    numphone = doc['numphone'];
    address = doc['address'];
    photo = doc['photo'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'numphone': numphone,
      'address': address,
      'photo': photo,
    };
  }
}
