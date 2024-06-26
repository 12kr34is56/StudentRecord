
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthEvent {}

class VerifyEmailEvent extends AuthEvent {}

class ResendVerificationEvent extends AuthEvent {}

class CheckVerificationEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}