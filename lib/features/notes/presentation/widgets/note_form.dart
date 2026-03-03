import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/notes/domain/entities/note.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:todo_app/features/notes/presentation/bloc/notes_event.dart';

class NoteForm extends StatefulWidget {
  final Note? note;

  const NoteForm({super.key, this.note});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    _isEditing = widget.note != null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        content: _contentController.text,
      );

      if (_isEditing) {
        context.read<NotesBloc>().add(UpdateNote(note));
      } else {
        context.read<NotesBloc>().add(AddNote(note));
      }

      Navigator.of(context).pop();
    }
  }

  void _cancel() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Content',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter content';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _submit,
                child: Text(_isEditing ? 'Update' : 'Save'),
              ),
              OutlinedButton(onPressed: _cancel, child: Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}