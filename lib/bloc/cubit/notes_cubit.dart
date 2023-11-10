import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Models/note_model.dart';
import 'package:notes_app/Repositories/notes_repo.dart';

import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitialState());
  NoteRepository noteRepository = NoteRepository();
  Future<void> getNote(NoteModel note) async {
    try {
      var notes = await noteRepository.getNotes(note);
      emit(NoteLoadedState(note: notes));
    } catch (e) {
      emit(NoteErrorState(error: e.toString()));
    }
  }

  Future<void> addNote(NoteModel note) async {
    var curState = state as NoteLoadedState;
    emit(NoteLoadingState());
    try {
      var myNote = await noteRepository.addNote(note);
      emit(NoteAddedSuccessState(notes: myNote, note: curState.note));
    } catch (e) {
      emit(NoteErrorState(error: e.toString()));
    }
  }

  Future<void> deleteNotebyId(String noteId) async {
    try {
      var isDeleted = await noteRepository.deleteNoteById(noteId);
      if (isDeleted) {
        emit(NoteDeleteState());
      } else {
        throw Exception("there was an issue with deleting");
      }
    } catch (e) {
      emit(NoteErrorState(error: e.toString()));
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      await noteRepository.updateNote(note);
      emit(NoteUpdatedState());
    } catch (e) {
      emit(NoteErrorState(error: e.toString()));
    }
  }
}
