import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Utils/Widgets/custom_textfiled.dart';
import 'package:notes_app/Utils/Widgets/description_textfiled.dart';
import 'package:notes_app/bloc/cubit/notes_cubit.dart';
import '../Utils/Widgets/custom_button.dart';
import '../Utils/common/common.dart';
import '../bloc/cubit/notes_state.dart';

class UpdateNotesScreen extends StatefulWidget {
  static const String routeName = "/UpdateNotesScreen";
  const UpdateNotesScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  final NoteModel note;

  @override
  State<UpdateNotesScreen> createState() => _UpdateNotesScreenState();
}

class _UpdateNotesScreenState extends State<UpdateNotesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title ?? '';
    descriptionController.text = widget.note.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          "Update Notes",
          style: GoogleFonts.montserrat(
            fontSize: 25.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<NotesCubit, NotesState>(
          listener: (context, state) {
            if (state is NoteUpdatedState) {
              showMyshowSnackBar(
                  context, "Note Updated Successfully", Colors.green);
            } else if (state is NoteErrorState) {
              showMyshowSnackBar(context, "Error: ${state.error}", Colors.red);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
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
                  SizedBox(height: 40.h),
                  CustombuttonWidget(
                    buttonHeight: 50.h,
                    buttonWidth: 350.w,
                    text: "Update Notes",
                    buttonBackgroundColor: Colors.deepPurpleAccent,
                    buttonborderRadius: 4,
                    onPressed: () => _updateNote(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _updateNote(BuildContext context) {
    if (titleController.text.isEmpty) {
      showMyshowSnackBar(context, "Enter Title", Colors.red);
      return;
    }

    if (descriptionController.text.isEmpty) {
      showMyshowSnackBar(context, "Enter description", Colors.red);
      return;
    }

    context.read<NotesCubit>().updateNote(NoteModel(
          id: widget.note.id,
          title: titleController.text,
          description: descriptionController.text,
          createAt: DateTime.now().millisecondsSinceEpoch,
        ));
  }
}
