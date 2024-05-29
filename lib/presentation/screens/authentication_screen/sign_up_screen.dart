import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/bloc.dart';
import '../../widget/widget.dart';
import 'authentication_screen.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const String routeName = "/sign-up-screen";

  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
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
                  const Text("Sign Up Form", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  WidgetTextField(
                      controller: emailController, hintText: "Email"),
                  WidgetTextField(
                    controller: passwordController,
                    obscureText: true,
                    hintText: "Password",
                  ),
                  ButtonBar(
                    children: [
                      WidgetButton(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        text: "Login",
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return WidgetButton(
                            onTap: () async {
                              if (state is! AuthLoading) {
                                // Dispatch SignUpEvent when the sign-up button is pressed
                                BlocProvider.of<AuthBloc>(context).add(
                                  SignUpEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: "Sign Up",
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
      bottomNavigationBar: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to verification screen after successful sign-up
            Navigator.pushReplacementNamed(
                context, VerificationScreen.routeName);
          }
        },
        child: SizedBox(),
      ),
    );
  }
}
