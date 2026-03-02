import 'package:todo_app/features/notes/data/datasources/note_local_data_source.dart';
import 'package:todo_app/features/notes/data/models/note_model.dart';
import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Note>> getAllNotes() async {
    final models = await localDataSource.getAllNotes();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    await localDataSource.addNote(model);
  }

  @override
  Future<void> updateNote(Note note) async {
    final model = NoteModel.fromEntity(note);
    await localDataSource.updateNote(model);
  }

  @override
  Future<void> deleteNote(int id) async {
    await localDataSource.deleteNote(id);
  }
}