import 'package:demo_movie/src/models/movie_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  static final MovieDatabase instance = MovieDatabase._init();

  static Database? _database;

  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    await db.execute('''
CREATE TABLE $tableMovie ( 
  ${MovieFields.id} $idType, 
  ${MovieFields.posterPath} $textType,
  ${MovieFields.voteAverage} $doubleType,
  ${MovieFields.voteCount} $integerType,
  ${MovieFields.title} $textType,
  ${MovieFields.overview} $textType,
  ${MovieFields.releaseDate} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableTrendingMovie ( 
  ${MovieFields.id} $idType, 
  ${MovieFields.posterPath} $textType,
  ${MovieFields.voteAverage} $doubleType,
  ${MovieFields.voteCount} $integerType,
  ${MovieFields.title} $textType,
  ${MovieFields.overview} $textType,
  ${MovieFields.releaseDate} $textType
  )
''');
  }

  Future<Movie> create(Movie movie, String tableName) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableName, movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> readMovieById(int id, String tableName) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: MovieFields.values,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Movie>> readAllMovies(String tableName) async {
    final db = await instance.database;

    const orderBy = '${MovieFields.releaseDate} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');orderBy: orderBy

    final result = await db.query(tableName);

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> update(Movie note, String tableName) async {
    final db = await instance.database;

    return db.update(
      tableName,
      note.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id, String tableName) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
