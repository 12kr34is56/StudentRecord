import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/bloc.dart';
import '../../presentation.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const String routeName = "/login-screen";
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Navigate to the home screen if authentication is successful
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text("Login Form", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    WidgetTextField(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    WidgetTextField(
                      obscureText: true,
                      controller: passwordController,
                      hintText: "Password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    ButtonBar(
                      children: [
                        WidgetButton(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
                          },
                          text: "Sign Up",
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return WidgetButton(
                              onTap: () async {
                                if (state is! AuthLoading) {
                                  // Validate form fields
                                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Please fill in all fields')),
                                    );
                                    return;
                                  }

                                  // Dispatch SignInEvent when the login button is pressed
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignInEvent(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              text: "Login",
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
