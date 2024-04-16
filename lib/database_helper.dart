import 'package:movie_app_two/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:movie_app_two/favorite.dart';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _db;

    DatabaseHelper._internal();

  factory DatabaseHelper() => instance;


  Future<Database> _getDatabase() async {
    _db ??= await openDatabase(
        'favorites.db',
        version: 1,
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE favorites (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              posterURL TEXT,
              overview TEXT,
              mediaType TEXT
            )
          ''');
        },
      );
    return _db!;
  }


  Future<List<Favorite>> getFavorites() async {
  final db = await _getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('favorites');
  return maps.isEmpty ? [] : List.generate(maps.length, (i) => Favorite.fromMap(maps[i]));
}
  Future<void> addFavorite(Favorite favorite) async {
    final db = await _getDatabase();
    await db.insert('favorites', favorite.toMap());
  }

  // Add methods for fetching favorites, removing favorites, etc.
}

extension FavoriteExtension on Favorite {
  Map<String, dynamic> toMap() => {
        'title': title,
        'posterURL': posterURL,
        'overview': overview,
        'mediaType': mediaType,
      };
}
void addToFavorites(Movie movie) async {
  final favorite = Favorite(
    title: movie.title,
    posterURL: movie.posterURL,
    overview: movie.overview,
    id: movie.id,
    year: movie.year,
    mediaType: "movie", // Assuming it's a movie for now
  );
  await DatabaseHelper.instance.addFavorite(favorite);



}