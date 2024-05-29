part of 'student_bloc.dart';


abstract class StudentEvent extends Equatable{
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class AddStudentEvent extends StudentEvent {
  final String name;
  final String gender;
  final DateTime dob;

  const AddStudentEvent({
    required this.name,
    required this.gender,
    required this.dob,
  });

  @override
  List<Object> get props => [name, gender, dob];
}

class UpdateStudentEvent extends StudentEvent {
  final String id;
  final String name;
  final String gender;
  final DateTime dob;

  const UpdateStudentEvent({
    required this.id,
    required this.name,
    required this.gender,
    required this.dob,
  });

  @override
  List<Object> get props => [id, name, gender, dob];
}

class FetchStudentsEvent extends StudentEvent {}

class NameChanged extends StudentEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class DobChanged extends StudentEvent {
  final DateTime dob;

  const DobChanged({required this.dob});

  @override
  List<Object> get props => [dob];
}
class GenderChanged extends StudentEvent {
  final String gender;

  const GenderChanged({required this.gender});

  @override
  List<Object> get props => [gender];
}


