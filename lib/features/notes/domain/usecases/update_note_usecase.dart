import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/domain/repositories/note_repository.dart';

class UpdateNoteUseCase {
  final NoteRepository repository;

  UpdateNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}
