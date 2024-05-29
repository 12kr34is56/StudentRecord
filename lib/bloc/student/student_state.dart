part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentAddedSuccess extends StudentState {}

class StudentUpdatedSuccess extends StudentState {}

class StudentListLoaded extends StudentState {
  final List<Student> students;

  const StudentListLoaded(this.students);

  @override
  List<Object?> get props => [students];
}

class StudentFailure extends StudentState {
  final String error;

  const StudentFailure(this.error);

  @override
  List<Object?> get props => [error];
}
