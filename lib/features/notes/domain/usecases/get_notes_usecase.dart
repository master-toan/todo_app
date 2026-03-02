import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/domain/repositories/note_repository.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call() async {
    return await repository.getAllNotes();
  }
}
