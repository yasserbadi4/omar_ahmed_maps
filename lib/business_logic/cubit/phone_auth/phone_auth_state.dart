part of 'phone_auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String errMsg;

  AuthError({required this.errMsg});
}

class PhoneNumberSubmitted extends AuthState {}

class PhoneOTPVerified extends AuthState {}
