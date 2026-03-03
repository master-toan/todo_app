import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/notes/data/datasources/note_local_data_source_impl.dart';
import 'package:todo_app/features/notes/data/repositories/note_repository_impl.dart';
import 'package:todo_app/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/update_note_usecase.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_event.dart';
import 'package:todo_app/features/notes/presentation/pages/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localDataSource = NoteLocalDataSourceImpl();
  final repository = NoteRepositoryImpl(localDataSource: localDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final NoteRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => NotesBloc(
          getNotes: GetNotesUseCase(repository),
          addNote: AddNoteUseCase(repository),
          updateNote: UpdateNoteUseCase(repository),
          deleteNote: DeleteNoteUseCase(repository),
        )..add(LoadNotes()),
        child: NotesPage(),
      ),
    );
  }
}