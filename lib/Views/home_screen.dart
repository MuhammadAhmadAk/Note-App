import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Utils/common/common.dart';
import 'package:notes_app/Views/add_notes_screen.dart';
import 'package:notes_app/Views/profile_screen.dart';
import 'package:notes_app/Views/update_notes_screen.dart';

import '../Models/user_model.dart';
import '../bloc/cubit/notes_cubit.dart';
import '../bloc/cubit/notes_state.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/HomeScreen";
  final UserModel userModel;
  const HomeScreen({
    super.key,
    required this.userModel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NoteModel? noteModel;
  getNote() async {
    await context
        .read<NotesCubit>()
        .getNote(NoteModel(creatorId: widget.userModel.uid));
  }

  getNotesModel() async {
    await context.read<NotesCubit>().getNote(noteModel!);
  }

  @override
  void initState() {
    getNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddNotesScreen.routeName,
                  arguments: widget.userModel);
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName,
                        arguments: widget.userModel.uid);
                  },
                  child: Icon(
                    Icons.person_2_outlined,
                    size: 30.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text("My Notes",
                    style: GoogleFonts.eduNswActFoundation(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    )),
              ],
            ),
            actions: [
              GestureDetector(onTap: getNotesModel, child: Icon(Icons.refresh)),
              SizedBox(
                width: 30.w,
              ),
              Icon(Icons.logout),
              SizedBox(
                width: 20.w,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                (state is NoteLoadedState)
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: state.note.length,
                          itemBuilder: (BuildContext context, int index) {
                            noteModel = state.note[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                              child: Card(
                                elevation: 0.6,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, UpdateNotesScreen.routeName,
                                        arguments: state.note[index]);
                                  },
                                  trailing: GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<NotesCubit>()
                                            .deleteNotebyId(
                                                state.note[index].id.toString())
                                            .then((value) => {
                                                  context
                                                      .read<NotesCubit>()
                                                      .getNote(NoteModel(
                                                          creatorId: widget
                                                              .userModel.uid))
                                                });
                                        showMyshowSnackBar(
                                            context, "Deleted", Colors.red);
                                      },
                                      child: Icon(Icons.delete_outline)),
                                  title: Text(
                                      state.note[index].title.toString(),
                                      style: GoogleFonts.eduNswActFoundation(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.7),
                                      )),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          state.note[index].description
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          )),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              DateFormat('dd/MM/yyyy  hh:mm a')
                                                  .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          state.note[index]
                                                              .createAt!
                                                              .toInt())),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : (state is NoteLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurpleAccent),
                          )
                        : Center(
                            child: Text(
                              "Add Notes",
                              style: GoogleFonts.eduNswActFoundation(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          )
              ],
            ),
          ),
        );
      },
    );
  }
}
