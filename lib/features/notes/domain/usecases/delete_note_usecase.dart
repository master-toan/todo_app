import 'package:todo_app/features/notes/domain/repositories/note_repository.dart';

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteNote(id);
  }
}
