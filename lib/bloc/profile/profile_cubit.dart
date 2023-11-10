import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Models/user_model.dart';
import 'package:notes_app/Repositories/profile_repo.dart';
import 'package:notes_app/bloc/profile/profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitialState());
  ProfileRepository profileRepository = ProfileRepository();
  Future<void> myProfile(UserModel user) async {
    try {
      var userData = await profileRepository.myProfile(user);
      emit(UserProfileLoadedState(user: userData));
    } catch (e) {
      emit(UserProfileErrorState(error: e.toString()));
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      await profileRepository.updateProfile(user);
    } catch (e) {
      emit(UserProfileErrorState(error: e.toString()));
    }
  }
}
