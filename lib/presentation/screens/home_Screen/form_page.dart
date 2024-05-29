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

  void _onGenderSelected(String gender) {
    context.read<StudentBloc>().add(GenderChanged(gender: gender));
  }

  void _onDateSelected(DateTime value) {
    context.read<StudentBloc>().add(DobChanged(dob: value));
  }

  void _onNameChanged(String name) {
    context.read<StudentBloc>().add(NameChanged(name: name));
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
      body: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Student Added')),
            );
            nameController.clear();
          } else if (state is StudentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add student: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.05,
                horizontal: width * 0.02,
              ),
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        //Name of Student
                        Text(
                           "Name ${nameController.text}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        //Image of Student
                        if (state.gender == "Other" || state.gender == null)
                          const ImageRotation(image: "images/dotted_image.jpeg"),
                        if (state.gender == "Female")
                          const ImageRotation(image: "images/girl.jpeg"),
                        if (state.gender == "Male")
                          const ImageRotation(image: "images/boy.jpeg"),

                        SizedBox(height: height * 0.02),

                        //Student DOB
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "DOB  ${state.dob != null ? "${state.dob!.day}-${state.dob!.month}-${state.dob!.year}" : ""}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                            onChanged: _onNameChanged,
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
                        WidgetGenderDropDown(
                          onGenderSelected: _onGenderSelected,
                        ),
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
                      color: Colors.green,
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (state.name.isEmpty ||
                            state.gender == null ||
                            state.dob == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                          return;
                        }

                        context.read<StudentBloc>().add(
                          AddStudentEvent(
                            name: state.name,
                            gender: state.gender!,
                            dob: state.dob!,
                          ),
                        );
                      },
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
