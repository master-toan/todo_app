import 'package:todo_app/features/notes/data/models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getAllNotes();

  Future<void> addNote(NoteModel note);

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNote(int id);
}