import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id;
  final String name;
  final String gender;
  final DateTime dob;

  Student({required this.id, required this.name, required this.gender, required this.dob});

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Student(
      id: doc.id,
      name: data['name'] ?? '',
      gender: data['gender'] ?? '',
      dob: DateTime.parse(data['dob']),
    );
  }
}