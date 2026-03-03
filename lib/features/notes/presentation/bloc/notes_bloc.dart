import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/delete_note_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:todo_app/features/notes/domain/usecases/update_note_usecase.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUseCase getNotes;
  final AddNoteUseCase addNote;
  final UpdateNoteUseCase updateNote;
  final DeleteNoteUseCase deleteNote;

  NotesBloc({
    required this.getNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NotesInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      await addNote(event.note);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      await updateNote(event.note);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      await deleteNote(event.id);
      add(LoadNotes());
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }
}