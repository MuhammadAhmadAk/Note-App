import 'package:notes_app/Models/user_model.dart';

class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthRegisterSuccessfullState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final UserModel user;
  AuthLoggedInState({required this.user});
}

class AuthErrorState extends AuthState {
  final String errorMessege;
  AuthErrorState({required this.errorMessege});
}
