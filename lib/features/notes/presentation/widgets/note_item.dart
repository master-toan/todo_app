import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_event.dart';
import 'package:todo_app/features/notes/presentation/widgets/note_form.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  void _editNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit Note', textAlign: TextAlign.center),
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
                child: NoteForm(note: note),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteNote(BuildContext context) =>
      context.read<NotesBloc>().add(DeleteNote(note.id!));

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editNote(context),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteNote(context),
            ),
          ],
        ),
      ),
    );
  }
}