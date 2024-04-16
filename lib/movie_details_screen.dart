import 'package:flutter/material.dart';
import 'package:movie_app_two/movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie ; // ndirclariw movie blifinal inside the constructor

const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

 // @override 

  //State<StatefulWidget> createState(){
    //return createMovieDetailsScreenState();
 // }
  //_MovieDetailsScreenState createMovieDetailsScreenState() => _MovieDetailsScreenState();
  @override
  MovieDetailsScreenState createState() => MovieDetailsScreenState();
}


class MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie; //bch naccew l movie mn widget
    debugPrint('Movie object in MovieDetailsScreen: $movie'); // Check the movie object


    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //hadi 4 disply mov poster
            Image.network(movie.posterURL),//hadi dyk image network

            // disply mov Title & year
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:Row(
                children: [
                  Text(
                    movie.title,
                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(), //bch nzido space betwen title & year
                  Text(movie.year),
                ],
              ),
            ),

                // BCH NDISPLAY movie desc if availb
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(movie.description ?? ''), // Use null-ish coalescing operator
            ),
          ],
        ),
      ),
    );
  }
}