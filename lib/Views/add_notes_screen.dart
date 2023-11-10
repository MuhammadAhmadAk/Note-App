import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/user_model.dart';
import 'package:notes_app/Utils/Widgets/custom_textfiled.dart';
import 'package:notes_app/Utils/Widgets/description_textfiled.dart';
import 'package:notes_app/Utils/common/common.dart';
import 'package:notes_app/Views/home_screen.dart';


import '../Models/note_model.dart';
import '../Utils/Widgets/custom_button.dart';
import '../bloc/cubit/notes_cubit.dart';
import '../bloc/cubit/notes_state.dart';

class AddNotesScreen extends StatefulWidget {
  static const String routeName = "/AddNotesScreen";
  final UserModel user;
  const AddNotesScreen({super.key, required this.user});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is NoteAddedSuccessState) {
          Navigator.pushNamed(context, HomeScreen.routeName,
              arguments: widget.user);
          showMyshowSnackBar(context, "Notes Added Successfull", Colors.green);
        } else if (state is NoteErrorState) {
          showMyshowSnackBar(context, state.error.toString(), Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            centerTitle: true,
            title: Text("Add Notes",
                style: GoogleFonts.montserrat(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.7),
                )),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [],
                ),
                CustomTextField(
                  controller: titleController,
                  hintText: "Title",
                ),
                DescriptionTextField(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 20,
                ),
                SizedBox(
                  height: 40.h,
                ),
                (state is NoteLoadingState)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                        ),
                      )
                    : CustombuttonWidget(
                        buttonHeight: 50.h,
                        buttonWidth: 350.w,
                        text: "Add Notes",
                        buttonBackgroundColor: Colors.deepPurpleAccent,
                        buttonborderRadius: 4,
                        onPressed: () async {
                          await context.read<NotesCubit>().addNote(NoteModel(
                              title: titleController.text.toString(),
                              creatorId: widget.user.uid.toString(),
                              description: descriptionController.text));
                        })
              ],
            ),
          )),
        );
      },
    );
  }
}
