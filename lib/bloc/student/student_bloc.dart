import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_record/model/student_model.dart';

import '../../data/repositories/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';


class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc({required this.studentRepository}) : super(const StudentInitial(name: '')) {
    on<AddStudentEvent>(_onAddStudent);
    on<FetchStudentsEvent>(_onFetchStudents);
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<DobChanged>((event, emit) {
      emit(state.copyWith(dob: event.dob));
    });

    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
  }

  Future<void> _onAddStudent(AddStudentEvent event, Emitter<StudentState> emit) async {
    emit(const StudentLoading());
    try {
      await studentRepository.addStudent(event.name, event.gender, event.dob);
      emit(StudentAddedSuccess());
    } catch (e) {
      emit(StudentFailure(e.toString()));
    }
  }

  Future<void> _onFetchStudents(FetchStudentsEvent event, Emitter<StudentState> emit) async {
    emit(const StudentLoading());
    try {
      final students = await studentRepository.getStudents().first;
      emit(StudentListLoaded(students));
    } catch (e) {
      emit(StudentFailure(e.toString()));
    }
  }

  Future<void> _onUpdateStudent(UpdateStudentEvent event, Emitter<StudentState> emit) async {
    emit(const StudentLoading());
    try {
      await studentRepository.updateStudent(event.id, event.name, event.gender, event.dob);
      emit(StudentUpdatedSuccess());
      add(FetchStudentsEvent());  // Fetch students again after updating one
    } catch (e) {
      emit(StudentFailure(e.toString()));
    }
  }



}