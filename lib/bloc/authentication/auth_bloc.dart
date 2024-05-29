
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_record/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<SignOutEvent>(_signOut);
    on<VerifyEmailEvent>(_verifyEmail);
    on<ResendVerificationEvent>(_onResendVerificationEvent);
    on<CheckVerificationEvent>(_onCheckVerificationEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
  }

  void _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.signIn(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  void _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final User? user = await authRepository.signUp(event.email, event.password);
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  void _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authRepository.signOut();
    emit(AuthUnauthenticated());
  }

  void _verifyEmail(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    User? user = authRepository.getCurrentUser();
    if (user != null && !user.emailVerified) {
      await authRepository.sendEmailVerificationLink();
      emit(EmailNotVerified());
    }
  }

  Future<void> _onResendVerificationEvent(
      ResendVerificationEvent event,
      Emitter<AuthState> emit,
      ) async {
    try {
      final currentUser = authRepository.getCurrentUser();
      if (currentUser != null) {
        await currentUser.sendEmailVerification();
        emit(AuthLoading());
        emit(AuthUnauthenticated()); // User needs to reauthenticate after email resend
      }
    } catch (e) {
      emit(AuthError('Failed to resend verification email: $e'));
    }
  }

  Future<void> _onCheckVerificationEvent(
      CheckVerificationEvent event,
      Emitter<AuthState> emit,
      ) async {
    final currentUser = authRepository.getCurrentUser();
    if (currentUser != null) {
      await currentUser.reload();
      if (currentUser.emailVerified) {
        emit(AuthAuthenticated(user: currentUser));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }
  Future<void> _onCheckAuthStatusEvent(
      CheckAuthStatusEvent event,
      Emitter<AuthState> emit,
      ) async {
    final currentUser = authRepository.getCurrentUser();
    if (currentUser != null && currentUser.emailVerified) {
      emit(AuthAuthenticated(user: currentUser));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
