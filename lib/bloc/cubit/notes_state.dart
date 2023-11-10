import 'package:notes_app/Models/note_model.dart';

class NotesState {}

final class NotesInitialState extends NotesState {}

class NoteLoadingState extends NotesState {}

class NoteLoadedState extends NotesState {
  final List<NoteModel> note;
  NoteLoadedState({required this.note});
}

class NoteAddedSuccessState extends NoteLoadedState {
  final NoteModel notes;
  NoteAddedSuccessState({required this.notes, required super.note});
}
class NoteUpdatedState extends NotesState {}

class NoteDeleteState extends NotesState {
  NoteDeleteState();
}

class NoteErrorState extends NotesState {
  final String error;
  NoteErrorState({required this.error});
}
