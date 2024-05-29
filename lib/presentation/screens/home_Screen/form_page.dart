import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record/data/data.dart';
import '../../../bloc/bloc.dart';
import '../../widget/widget.dart';
import '../screens.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController nameController = TextEditingController();
  String? selectedGender;
  DateTime? selectedDob;

  void onGenderSelected(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void _onDateSelected(DateTime value) {
    setState(() {
      selectedDob = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
        actions: [
          //logout button
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUnauthenticated) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              icon: const Icon(Icons.logout, color: Colors.red),
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            StudentBloc(studentRepository: StudentRepository()),
        child: BlocListener<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is StudentAddedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Student Added')),
              );
              nameController.clear();
              setState(() {
                selectedGender = null;
                selectedDob = null;
              });
            } else if (state is StudentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to add student: ${state.error}')),
              );
            }
          },
          child: ListView(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.05, horizontal: width * 0.02),
            children: [
              Row(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name of Student
                      Text(
                          nameController.text.isEmpty
                              ? "Name"
                              : nameController.text,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),

                      //Image of Student
                      if (selectedGender == "Other" || selectedGender == null)
                        const ImageRotation(image: "images/dotted_image.jpeg"),
                      if (selectedGender == "Female")
                        const ImageRotation(image: "images/girl.jpeg"),
                      if (selectedGender == "Male")
                        const ImageRotation(image: "images/boy.jpeg"),

                      SizedBox(height: height * 0.02),

                      //Student DOB

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                            "DOB  ${selectedDob != null ? "${selectedDob!.day}-${selectedDob!.month}-${selectedDob!.year}" : ""}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),

                      SizedBox(height: height * 0.02),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                        width: width * 0.4,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      WidgetDatePicker(
                        helpText: "Select Date",
                        onDateSelected: _onDateSelected,
                      ),
                      SizedBox(height: height * 0.02),
                      WidgetGenderDropDown(onGenderSelected: onGenderSelected),
                      SizedBox(height: height * 0.02),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              //Submit Button
              Center(
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: InkWell(
                    onTap: () async {
                      if (nameController.text.isNotEmpty &&
                          selectedGender != null &&
                          selectedDob != null) {
                        context.read<StudentBloc>().add(AddStudentEvent(
                              name: nameController.text,
                              gender: selectedGender!,
                              dob: selectedDob!,
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Student Added')),
                        );
                        nameController.clear();
                        setState(() {
                          selectedGender = null;
                          selectedDob = null;
                        });
                      }
                    },
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
