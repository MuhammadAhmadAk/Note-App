import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/user_model.dart';
import 'package:notes_app/Utils/common/common.dart';
import 'package:notes_app/bloc/profile/profile_cubit.dart';
import 'package:notes_app/bloc/profile/profile_state.dart';

import '../Utils/Widgets/custom_button.dart';
import '../Utils/Widgets/custom_textfiled.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/ProfileScreen";
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<UserProfileCubit>().myProfile(UserModel(uid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text("Update Profile",
            style: GoogleFonts.montserrat(
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.7),
            )),
      ),
      body: SafeArea(child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadedState) {
            usernameController.value =
                TextEditingValue(text: state.user.username.toString());
            emailController.value =
                TextEditingValue(text: state.user.email.toString());
            return Container(
              margin: EdgeInsets.all(18.w),
              child: Column(
                children: [
                  Row(
                    children: [],
                  ),
                  CustomTextField(
                    hintText: "Username",
                    inputType: TextInputType.name,
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AbsorbPointer(
                    child: CustomTextField(
                      hintText: "Email",
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustombuttonWidget(
                      buttonHeight: 50.h,
                      buttonWidth: 350.w,
                      text: "Update",
                      buttonBackgroundColor: Colors.deepPurpleAccent,
                      buttonborderRadius: 4,
                      onPressed: updateDetails),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }
        },
      )),
    );
  }

  void updateDetails() {
    if (usernameController.text.isEmpty) {
      showMyshowSnackBar(context, "Enter Username", Colors.red);
      return;
    }
    context
        .read<UserProfileCubit>()
        .updateProfile(
            UserModel(uid: widget.uid, username: usernameController.text))
        .then((value) {
      showMyshowSnackBar(context, "Profile Updated Successfully", Colors.green);
    });
  }
}
