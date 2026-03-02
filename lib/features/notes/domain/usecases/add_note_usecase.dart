import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/domain/repositories/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    await repository.addNote(note);
  }
}