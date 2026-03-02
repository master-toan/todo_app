import 'package:todo_app/features/notes/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();

  Future<void> addNote(Note note);

  Future<void> updateNote(Note note);

  Future<void> deleteNote(int id);
}
