import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Repositories/auth_repo.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  AuthRepository authRepository = AuthRepository();

  Future<void> register(String username, String email, String password) async {
    emit(AuthLoadingState());
    try {
      var user = await authRepository.registerUser(username, email, password);
      if (user) {
        emit(AuthRegisterSuccessfullState());
      } else {
        print("server error");
      }
    } on Exception catch (e) {
      print(e.toString());
      emit(AuthErrorState(errorMessege: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      var user = await authRepository.login(email, password);
      emit(AuthLoggedInState(user: user));
    } catch (e) {
      emit(AuthErrorState(errorMessege: e.toString()));
    }
  }
}
