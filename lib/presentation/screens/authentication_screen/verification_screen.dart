import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record/presentation/presentation.dart';
import '../../../bloc/bloc.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = "/verification-screen";

  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late Timer timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    final authBloc = BlocProvider.of<AuthBloc>(context);

    authBloc.add(VerifyEmailEvent());

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      authBloc.add(CheckVerificationEvent());
      // Dispatch CheckVerificationEvent periodically
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  Future<void> resendVerificationEmail() async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(ResendVerificationEvent()); // Dispatch ResendVerificationEvent to resend the verification email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              timer.cancel(); // Cancel the timer when the user is authenticated
              Navigator.pushReplacementNamed(context, HomeScreen.routeName); // Navigate to the home screen after successful verification
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "A verification email has been sent to ${FirebaseAuth.instance.currentUser?.email}. Please check your email and click on the verification link.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: canResendEmail ? resendVerificationEmail : null,
                child: const Text("Resend Email"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}