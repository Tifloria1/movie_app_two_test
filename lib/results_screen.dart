import 'package:flutter/material.dart';
import 'package:movie_app_two/movie.dart';

class ResultsScreen extends StatefulWidget {
  final List<Movie> movies;

  const ResultsScreen({super.key, required this.movies});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Resultas de la Recherche'),
      ),
      body: ListView.builder(
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return ListTile(
            title: Text(movie.title),
            onTap:() {

            },
          );
          },
        ),
    );
  }
}
