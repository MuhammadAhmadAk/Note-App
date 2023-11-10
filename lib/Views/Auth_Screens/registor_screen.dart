import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Utils/common/common.dart';
import 'package:notes_app/Views/Auth_Screens/login_screen.dart';
import 'package:notes_app/bloc/auth/auth_cubit.dart';
import 'package:notes_app/bloc/auth/auth_state.dart';

import '../../Utils/Widgets/custom_button.dart';
import '../../Utils/Widgets/custom_paswordfield.dart';
import '../../Utils/Widgets/custom_textfiled.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void clearController() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessfullState) {
          Navigator.pushNamed(context, LoginScreen.routeName);
          showMyshowSnackBar(context, "Register Successfull", Colors.green);
          clearController();
        } else if (state is AuthErrorState) {
          showMyshowSnackBar(
              context, state.errorMessege.toString(), Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
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
                    Text("Register",
                        style: GoogleFonts.montserrat(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        )),
                  ],
                ),
                CustomTextField(
                  hintText: "Username",
                  inputType: TextInputType.name,
                  controller: usernameController,
                ),
                SizedBox(
                  height: 10.h,
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
                        child: CircularProgressIndicator(
                            color: Colors.deepPurpleAccent),
                      )
                    : CustombuttonWidget(
                        buttonHeight: 50.h,
                        buttonWidth: 350.w,
                        text: "Register",
                        buttonBackgroundColor: Colors.deepPurpleAccent,
                        buttonborderRadius: 4,
                        onPressed: () async {
                          await context.read<AuthCubit>().register(
                              usernameController.text,
                              emailController.text.trim(),
                              passwordController.text);
                        }),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ? ",
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
                            context, LoginScreen.routeName, (route) => false);
                      },
                      child: Text("Login",
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurpleAccent.withOpacity(0.7),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
