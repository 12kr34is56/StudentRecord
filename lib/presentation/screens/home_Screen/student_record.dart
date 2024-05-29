import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record/bloc/bloc.dart';
import '../../widget/widget.dart';

class StudentRecord extends StatefulWidget {
  const StudentRecord({Key? key}) : super(key: key);

  @override
  State<StudentRecord> createState() => _StudentRecordState();
}

class _StudentRecordState extends State<StudentRecord> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(FetchStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentFailure) {
            return Center(child: Text('Error loading students: ${state.error}'));
          } else if (state is StudentListLoaded) {
            final students = state.students;

            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final name = student.name;
                final gender = student.gender;
                final dob = student.dob;

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      gender == "Male" ? "images/boy.jpeg" : "images/girl.jpeg",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(name),
                  subtitle: Text(dob.toShortString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final nameController = TextEditingController(text: name);
                          final selectedGender = gender;
                          final selectedDob = dob;

                          return WidgetEditInformationDialogBox(
                            id: student.id,
                            nameController: nameController,
                            dob: selectedDob,
                            gender: selectedGender,
                            onUpdate: (updatedName, updatedGender, updatedDob) {
                              context.read<StudentBloc>().add(
                                UpdateStudentEvent(
                                  id: student.id,
                                  name: updatedName,
                                  gender: updatedGender,
                                  dob: updatedDob,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No students found'));
          }
        },
      ),
    );
  }
}

extension DateTimeExtensions on DateTime {
  String toShortString() {
    return '$day/$month/$year';
  }
}
