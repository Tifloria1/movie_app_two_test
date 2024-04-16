import 'package:flutter/material.dart';
import 'package:movie_app_two/favorite.dart';
import 'package:movie_app_two/movie.dart';
import 'package:movie_app_two/movie_details_screen.dart';
import 'package:movie_app_two/database_helper.dart';



class FavoritesScreen extends StatefulWidget {
  final String apiKey;

  const FavoritesScreen({required this.apiKey, super.key});
      

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}
  class _FavoritesScreenState extends State<FavoritesScreen> {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;
    List<Favorite> _favorites = [];// Change to List<Favorite>


    /*//bch nstoriw fav mov blist<Movie>
    final List<Movie> _favorites = [];

  static const String apiKey = 'YOUR_OMDB_API_KEY'; // Replace with your actual key


    String getMovieDetailsURL(String movieId) {
    return 'http://www.omdbapi.com/?apikey=$apiKey&i=$movieId'; // Assuming ID is in 'i'

  }

    // Add methods for managing favorites (optional)
  void addToFavorites(Movie movie) {
    setState(() {
      _favorites.add(movie);
    });
  }
     */

  @override 
  Widget build(BuildContext context){
    Future<void> _getFavorites() async {
  final favorites = await databaseHelper.getFavorites();
  setState(() {
    _favorites = favorites; // Now we can update the list
  });
}

_getFavorites();  // Call the function to fetch favorites
    return Scaffold(
      appBar : AppBar(
        title: const Text('Favorites'),
    ),
    body: _favorites.isEmpty
        ? const Center(
             child: Text('No Favorites yet'),
         )
        :ListView.builder(
          itemCount: _favorites.length,
          itemBuilder: (context, index) {
            final movie = _favorites[index];
            return ListTile(
              title: Text(movie.title), 
              subtitle:Text(movie.year),
              onTap: () => //Navigiw l movie details screen,
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    movie: Movie(
                      title: movie.title,
                      year: movie.year,
                      posterURL: movie.posterURL,
                      overview: movie.overview,
                    ),
              ),
              ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeFavorite(movie.id) // Call removeFavorite
              ),
            );
          },
        ),

    );

  }
void _removeFavorite(int id) async {
  }
  }
