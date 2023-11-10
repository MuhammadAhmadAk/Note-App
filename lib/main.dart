import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/Router/on_generated_routes.dart';
import 'package:notes_app/Views/Auth_Screens/login_screen.dart';

import 'package:notes_app/bloc/auth/auth_cubit.dart';
import 'package:notes_app/bloc/profile/profile_cubit.dart';

import 'bloc/cubit/notes_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
              create: (context) => UserProfileCubit(),
            ),
            BlocProvider(
              create: (context) => NotesCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                useMaterial3: true,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)),
            title: 'Notes App',
            onGenerateRoute: OnGeneratedRoutes.route,
            routes: {
              '/': (context) {
                return LoginScreen();
              }
            },
          ),
        );
      },
    );
  }
}
