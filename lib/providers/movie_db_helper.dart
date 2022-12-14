import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modals/movie.dart';

class MovieDBHelper {
  MovieDBHelper._();

  static final MovieDBHelper movieDBHelper = MovieDBHelper._();

  String tableName = "movie";
  String colId = "id";
  String colName = "name";
  String colGenre = "genre";
  String colType = "type";
  String colLanguage = "language";
  String colWood = "wood";
  String colRating = "rating";

  Database? db;

  Future<Database> initDatabase() async {
    var db = await openDatabase("myDb.db");

    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, "myDB.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int vision) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colGenre TEXT,$colType TEXT,$colLanguage TEXT,$colWood TEXT,$colRating TEXT);");
      },
    );
    return db;
  }

  Future<int> insertData({required Movie data}) async {
    db = await initDatabase();

    String query = "INSERT INTO $tableName VALUES (?, ?, ?, ?, ?, ?, ?);";
    List arg = [
      data.id,
      data.name,
      data.genre,
      data.type,
      data.language,
      data.wood,
      data.rating,
    ];
    return await db!.rawInsert(query, arg);
  }

  Future<List<Movie>> fetchAllData() async {
    db = await initDatabase();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<Movie> movieData = res.map((e) => Movie.fromMap(data: e)).toList();

    return movieData;
  }

  Future<int> updateData({required Movie data, int? id}) async {
    db = await initDatabase();

    String query = "UPDATE $tableName SET $colName = ?, $colGenre = ?, $colType = ?, $colRating = ?, $colWood = ?, $colLanguage = ? WHERE id=?;";

    List args = [
      data.name,
      data.genre,
      data.type,
      data.rating,
      data.wood,
      data.language,
      id,
    ];

    return await db!.rawUpdate(query, args);
  }

  Future<int> deleteSingleData({required int id}) async {
    db = await initDatabase();

    String query = "DELETE FROM $tableName WHERE id=$id";
    return await db!.rawDelete(query);

  }
}
