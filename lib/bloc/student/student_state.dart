part of 'student_bloc.dart';

class StudentState extends Equatable {
  final String name;
  final String? gender;
  final DateTime? dob;

  const StudentState({
    required this.name,
    this.gender,
    this.dob,
  });

  StudentState copyWith({
    String? name,
    String? gender,
    DateTime? dob,
  }) {
    return StudentState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
    );
  }

  @override
  List<Object?> get props => [name, gender, dob];
}






class StudentInitial extends StudentState {
  const StudentInitial({required String name}) : super(name: name);
}
class StudentLoading extends StudentState {
  const StudentLoading([String name = '']) : super(name: name);
}

class StudentAddedSuccess extends StudentState {
  StudentAddedSuccess([String name = '']) : super(name: name);
}

class StudentUpdatedSuccess extends StudentState {
  StudentUpdatedSuccess([String name = '']) : super(name: name);
}

class StudentListLoaded extends StudentState {
  final List<Student> students;

  const StudentListLoaded(this.students) : super(name: '');

  @override
  List<Object?> get props => [students];
}

class StudentFailure extends StudentState {
  final String error;

  const StudentFailure(this.error) : super(name: '');

  @override
  List<Object?> get props => [error];
}
