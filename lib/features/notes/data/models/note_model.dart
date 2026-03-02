import 'package:todo_app/features/notes/domain/entities/note.dart';

class NoteModel {
  final int? id;
  final String title;
  final String content;

  NoteModel({this.id, required this.title, required this.content});

  // JSON → NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

  // NoteModel → JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content};
  }

  // NoteModel → Note
  Note toEntity() {
    return Note(id: id, title: title, content: content);
  }

  // Note → NoteModel
  factory NoteModel.fromEntity(Note note) {
    return NoteModel(id: note.id, title: note.title, content: note.content);
  }
}