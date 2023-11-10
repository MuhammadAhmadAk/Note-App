import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Utils/Widgets/custom_button.dart';
import 'package:notes_app/Utils/Widgets/custom_paswordfield.dart';
import 'package:notes_app/Utils/Widgets/custom_textfiled.dart';
import 'package:notes_app/Views/Auth_Screens/registor_screen.dart';
import 'package:notes_app/Views/home_screen.dart';
import 'package:notes_app/bloc/auth/auth_cubit.dart';
import 'package:notes_app/bloc/auth/auth_state.dart';

import '../../Utils/common/common.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/Login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedInState) {
          Navigator.pushNamed(context, HomeScreen.routeName,
              arguments: state.user);
          showMyshowSnackBar(context, "Login Successfull", Colors.green);
          clearController();
        } else if (state is AuthErrorState) {
          showMyshowSnackBar(
              context, state.errorMessege.toString(), Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Notes App",
                      style: GoogleFonts.eduNswActFoundation(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      )),
                ],
              ),
              SizedBox(
                height: 45.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login",
                      style: GoogleFonts.montserrat(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      )),
                ],
              ),
              CustomTextField(
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(
                height: 10.h,
              ),
              PasswordTextfield(
                hintText: "Password",
                controller: passwordController,
              ),
              SizedBox(
                height: 40.h,
              ),
              (state is AuthLoadingState)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustombuttonWidget(
                      buttonHeight: 50.h,
                      buttonWidth: 350.w,
                      text: "Login",
                      buttonBackgroundColor: Colors.deepPurpleAccent,
                      buttonborderRadius: 4,
                      onPressed: () async {
                        await context.read<AuthCubit>().login(
                            emailController.text.trim(),
                            passwordController.text);
                      }),
              SizedBox(
                height: 12.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have a account ?",
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      )),
                  SizedBox(
                    width: 12.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RegisterScreen.routeName, (route) => false);
                    },
                    child: Text("Register",
                        style: GoogleFonts.montserrat(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurpleAccent.withOpacity(0.7),
                        )),
                  ),
                ],
              ),
            ],
          )),
        );
      },
    );
  }
}
