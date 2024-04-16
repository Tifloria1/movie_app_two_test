import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // for JSON decoding

class Movie {
  final String title;
  final String year;
  final String posterURL;
  final String? description;
  final String? imdbID;
  final String overview;


  const Movie({
    required this.title,
    required this.year,
    required this.posterURL,  
    this.description, //optional
    this.imdbID, //optional
    required this.overview, //
  });

    factory Movie.fromMap(Map<String, dynamic> map) => Movie(
        title: map['title'] as String,
        year: map['year'] as String, // Assuming year is present in JSON
        overview: map['overview'] as String, posterURL: '',
      );

  get id => null;
}


class DetailedMovieInfo {
  final String title;
  final String year; // Already included
  final String rated;
  final String released;
  final String runtime; // Assuming runtime is available
  final List<String> genre;
  final String director;
  final String writer;
  final List<String> actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<Map<String, String>> ratings; // Assuming ratings is an array of objects

  // ... other fields as needed

  DetailedMovieInfo({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    
  });
  factory DetailedMovieInfo.fromJson(Map<String, dynamic> json) {
    // Update the logic to parse the additional fields
    final title = json['Title'] ?? '';
    final year = json['Year'] ?? '';
    final rated = json['Rated'] ?? '';
    final released = json['Released'] ?? '';
    final runtime = json['Runtime'] ?? '';
    final genre = (json['Genre'] as String?)?.split(',').map((g) => g.trim()).toList() ?? [];
    final director = json['Director'] ?? '';
    final writer = json['Writer'] ?? '';
    final actors = (json['Actors'] as String?)?.split(',').map((actor) => actor.trim()).toList() ?? [];
    final plot = json['Plot'] ?? '';
    final language = json['Language'] ?? '';
    final country = json['Country'] ?? '';
    final awards = json['Awards'] ?? '';
    final poster = json['Poster'] ?? '';
    final ratings = (json['Ratings'] as List?)?.map((rating) => rating as Map<String, String>).toList() ?? [];

    return DetailedMovieInfo(
      title: title,
      year: year,
      rated: rated,
      released: released,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot,
      language: language,
      country: country,
      awards: awards,
      poster: poster,
      ratings: ratings,
    );
  }
}  

class MovieListState extends State<StatefulWidget> {
  int currentPage = 1;
  List <Movie> movies = [];
    final String _searchTerm = ''; // Define and initialize _searchTerm

  void _loadMoreMovies() async {
  const apiKey = 'fc05eb53'; // Replace with your actual key
  final searchQuery = _searchTerm; // Access search term from state
  var currentPage = this.currentPage; // Access current page

  final url = Uri.parse(
    'http://www.omdbapi.com/?apikey=$apiKey&s=$searchQuery&page=$currentPage');
  debugPrint('URL: $url'); // Verify the value
  
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> moviesData = jsonData['Search'];//assuming list

  // Extract movie info from each elemetn in moviesdata
      final newMovies = moviesData.map((movieData){
       final title = movieData['Title'];
       final year = movieData ['Year'];
       final posterURL =
           movieData.containsKey('Poster') ? movieData['Poster'] : '';
       final description = movieData['Description'];

       return Movie(
         title: title,
         year: year,
         posterURL: posterURL,
         description: description, overview: '',
       );
      }).toList();     //tocreat list of movie object


    //Extract poster URL AND OTHER DETAILS IF AVAIL

      setState(() {
        movies.addAll(newMovies);
        debugPrint('Current Page Before Increment: $currentPage');
        currentPage++;
        debugPrint('Current Page After Increment: $currentPage');
     });

   
  } else {
    debugPrint('Error: ${response.statusCode}'); // Print error message
  }
 }  catch (error) {
    debugPrint('error fetching movies :$error');
 }
}
@override
  void initState() {
    super.initState();
    _loadMoreMovies(); // Call initially to load first page
  }

void _fetchDetailedInfo(String imdbID) async {
  const apiKey = 'fc05eb53'; // Replace with your actual key
  final url = Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&i=$imdbID');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final detailedInfo = DetailedMovieInfo.fromJson(jsonData);

      // You can use the detailedInfo object here to display details (e.g., in a modal)
      debugPrint(detailedInfo.title); // Example usage
    } else {
      debugPrint('Error fetching detailed info: ${response.statusCode}');
    }
  } catch (error) {
    debugPrint('Error: $error');
  }
}


@override
  Widget build(BuildContext context) {
      //_loadMoreMovies(); // Call initially to load first page

    /*// This method defines the UI structure of the movie list screen
    // You can use widgets like Scaffold, ListView, ListTile, etc.
    // to build the UI based on the movies list and other state variables.*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
      final imdbID = movie.imdbID; /* property containing imdbID */// Access the IMDB ID from the Movie object
      _fetchDetailedInfo(imdbID!);
    },
    child: ListTile(
      leading: movie.posterURL.isNotEmpty
          ? Image.network(movie.posterURL) // Display poster if available
          : null, // Or a placeholder widget (e.g., Icon(Icons.movie))
      title: Text(movie.title),
      subtitle: Text(movie.year),
    ),
            );
          }),  
        
              );
          }
      
      
  }

      /*ElevatedButton(
        onPressed: () {
          _loadMoreMovies(); // Call the function to load more movies
        },
        child: Text('Load More Movies'),
      ),
    );
  }
}
*/