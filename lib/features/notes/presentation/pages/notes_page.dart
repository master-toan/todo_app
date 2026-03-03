import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_state.dart';
import 'package:todo_app/features/notes/presentation/widgets/note_form.dart';
import 'package:todo_app/features/notes/presentation/widgets/note_item.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  void _addNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Add Note', textAlign: TextAlign.center),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: BlocProvider.value(
                value: context.read<NotesBloc>(),
                child: NoteForm(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return Center(
                child: Text(
                  'No notes yet. Add one!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                return NoteItem(note: state.notes[index]);
              },
            );
          }

          if (state is NotesError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(context),
        child: Icon(Icons.add),
      ),
    );
  }
}