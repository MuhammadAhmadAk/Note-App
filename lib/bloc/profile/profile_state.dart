import '../../Models/user_model.dart';

class UserProfileState {}

final class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadedState extends UserProfileState {
  final UserModel user;

  UserProfileLoadedState({required this.user});
}

class UserProfileErrorState extends UserProfileState {
  final String error;
  UserProfileErrorState({required this.error});
}
