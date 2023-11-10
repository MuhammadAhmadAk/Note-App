import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Utils/Widgets/custom_button.dart';
import 'package:notes_app/Views/Auth_Screens/login_screen.dart';
import 'package:notes_app/Views/Auth_Screens/registor_screen.dart';
import 'package:notes_app/Views/add_notes_screen.dart';
import 'package:notes_app/Views/home_screen.dart';
import 'package:notes_app/Views/profile_screen.dart';
import 'package:notes_app/Views/update_notes_screen.dart';

import '../Models/user_model.dart';

class OnGeneratedRoutes {
  static Route<dynamic> route(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case LoginScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => LoginScreen(),
          );
        }
      case RegisterScreen.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          );
        }
      case HomeScreen.routeName:
        {
          if (arg is UserModel) {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(
                userModel: arg,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => ErrorPage(),
            );
          }
        }
      case ProfileScreen.routeName:
        {
          if (arg is String) {
            return MaterialPageRoute(
              builder: (context) => ProfileScreen(
                uid: arg,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => ErrorPage(),
            );
          }
        }
      case AddNotesScreen.routeName:
        {
          if (arg is UserModel) {
            return MaterialPageRoute(
              builder: (context) => AddNotesScreen(
                user: arg,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => ErrorPage(),
            );
          }
        }

      case UpdateNotesScreen.routeName:
        {
          if (arg is NoteModel) {
            return MaterialPageRoute(
              builder: (context) => UpdateNotesScreen(
                note: arg,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => ErrorPage(),
            );
          }
        }
      default:
        return MaterialPageRoute(
          builder: (context) => ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red.withOpacity(0.9),
            ),
            Text(
              'Oops, something went wrong!',
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            Text(
              "Error",
              style: GoogleFonts.montserrat(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 20),
            CustombuttonWidget(
                text: "Go back",
                buttonWidth: 170.w,
                buttonHeight: 40.h,
                buttonBackgroundColor: Colors.deepPurpleAccent,
                buttonborderRadius: 20.r,
                fontWeight: FontWeight.w300,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
