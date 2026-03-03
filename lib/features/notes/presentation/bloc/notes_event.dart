import 'package:todo_app/features/notes/domain/entities/note.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;

  AddNote(this.note);
}

class UpdateNote extends NotesEvent {
  final Note note;

  UpdateNote(this.note);
}

class DeleteNote extends NotesEvent {
  final int id;

  DeleteNote(this.id);
}