import 'package:demo_movie/src/models/genres_model.dart';
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
  ${MovieFields.releaseDate} $textType,
  ${MovieFields.genreId1} $integerType,
  ${MovieFields.genreId2} $integerType
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
  ${MovieFields.releaseDate} $textType,
  ${MovieFields.genreId1} $integerType,
  ${MovieFields.genreId2} $integerType
  
  )
''');

    await db.execute('''
CREATE TABLE $tableGenres ( 
  ${GenresField.gid} $idType, 
  ${GenresField.name} $textType
  )
''');
  }

// ${MovieFields.genreId3} $integerType
  Future<Movie> createMovie(Movie movie, String tableName) async {
    final db = await instance.database;
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
    print("Result");
    print("___________________________");
    print(result);
    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> updateMovie(Movie note, String tableName) async {
    final db = await instance.database;

    return db.update(
      tableName,
      note.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteMovie(int id, String tableName) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<Movie> readMovieByGenreId(int id, String tableName) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: MovieFields.values,
      where: '${MovieFields.genreId1} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  /// genre table functions
  Future<GenresModel> createGenre(GenresModel genre) async {
    final db = await instance.database;
    final id = await db.insert(tableGenres, genre.toJson());
    return genre.copy(gid: id);
  }

  Future<GenresModel> readGenreById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGenres,
      columns: GenresField.values,
      where: '${GenresField.gid} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GenresModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<GenresModel>> readAllGenres() async {
    print("Genressss");
    final db = await instance.database;

    const orderBy = '${GenresField.gid} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');orderBy: orderBy

    final result = await db.query(tableGenres);
    return result.map((json) => GenresModel.fromJson(json)).toList();
  }

  /// genre movies
  Future<List<Movie>> readAllMoviesByGenre(String genreId) async {
    List<Movie> moviesByGenre = [];
    List<Movie> moviesByGenreList = [];
    List<Movie> moviesList1 = [];
    List<Movie> moviesList2 = [];
    List<Movie> newList = [];
    final db = await instance.database;

    const orderBy = '${MovieFields.releaseDate} ASC';
    // final query = await db.rawQuery('SELECT * FROM $tableMovie ORDER BY $orderBy');
    // var query =
    //     'SELECT * FROM $tableMovie WHERE ${MovieFields.genreId1} = ?  OR  ${MovieFields.genreId2} = ?';

    /// selecting movies from movies table and trending list table of a particular genre
    var query1 =
        'SELECT * FROM $tableMovie WHERE $genreId IN (${MovieFields.genreId1},${MovieFields.genreId2}) ';
    var query2 =
        'SELECT * FROM $tableTrendingMovie WHERE $genreId IN (${MovieFields.genreId1},${MovieFields.genreId2}) ';

    /// results into two seperate lists
    var queryResult1 = await db.rawQuery(query1);
    var queryResult2 = await db.rawQuery(query2);

    moviesList1 = queryResult1.map((json) => Movie.fromJson(json)).toList();
    moviesList2 = queryResult2.map((json) => Movie.fromJson(json)).toList();

    for (int i = 0; i < moviesList1.length; i++) {
      moviesByGenre.add(moviesList1[i]);
    }

    for (int i = 0; i < moviesList2.length; i++) {
      for (int j = 0; j < moviesByGenre.length; j++) {
        print(
            "List one ${moviesByGenre[j].title ?? "dj"}   List Two ${moviesList2[i].title ?? "dj"}");
        if (moviesList2[i].title != moviesByGenre[j].title) {
          print("Adding ${moviesList2[i].title ?? "dj"}");
          moviesByGenreList.add(moviesList2[i]);
        }
      }
    }

    // newList = (List.from(moviesByGenre)..addAll(moviesByGenreList));

    /// concatanating two lists into single one
    // var newList = (List.from(queryResult1)..addAll(queryResult2));
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    print(newList);

    final result = await db.query(
      tableMovie,
      columns: MovieFields.values,
      where: '${MovieFields.genreId1} = ?',
      whereArgs: [28],
    );

    print("Movies By Genre");
    print(genreId);
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    for (int i = 0; i < newList.length; i++) {
      print(newList[i].title ?? "Null");
    }

    return moviesByGenreList.toSet().toList();
  }

  /// delete table
  Future delete(String table) async {
    final db = await instance.database;

    return await db.delete(
      table,
    );
  }

  /// getGenre
  Future<String> getGenreName(int id) async {
    final db = await instance.database;
    var query1 = 'SELECT ${GenresField.name} FROM $tableGenres WHERE $id = ? ';
    final result = db.rawQuery(query1).toString();
    print("Selected Genre is $result");
    return result;
  }
}
