import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/features/notes/data/models/note_model.dart';
import 'note_local_data_source.dart';

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  static final NoteLocalDataSourceImpl _instance =
      NoteLocalDataSourceImpl._internal();

  factory NoteLocalDataSourceImpl() => _instance;

  NoteLocalDataSourceImpl._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final db = await database;
    final result = await db.query('notes');
    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  @override
  Future<void> addNote(NoteModel note) async {
    final db = await database;
    await db.insert('notes', note.toJson());
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  @override
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}