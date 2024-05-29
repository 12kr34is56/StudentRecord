import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_record/model/model.dart';

class StudentRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> addStudent(String name, String gender, DateTime dob) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('students').add({
          'name': name,
          'gender': gender,
          'dob': dob.toIso8601String(),
          'userId': user.uid,
        });
      } catch (e) {
        // Handle exceptions
      }
    } else {
      // Handle unauthenticated user
    }
  }

   Stream<List<Student>> getStudents() {
    return _firestore
        .collection('students')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList());
  }

   Future<void> updateStudent(String id, String name, String gender, DateTime dob) async {
    try {
      await _firestore.collection('students').doc(id).update({
        'name': name,
        'gender': gender,
        'dob': dob.toIso8601String(),
      });
    } catch (e) {
      // Handle exceptions
    }
  }
}