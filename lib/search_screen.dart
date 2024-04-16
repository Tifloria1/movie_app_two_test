import 'package:flutter/material.dart';
import 'package:movie_app_two/movie_details_screen.dart';

import 'search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final _searchTermController = TextEditingController();
  
  String _searchTerm = '';
  Future<List<dynamic>>? _searchResults;
  int _currentPage = 1; // Add state variable for current page

  

  void _onSearch() {
    if (_searchTerm.isNotEmpty) {
      setState(() {
        _currentPage = 1; // Reset page on new search
        _searchResults = searchMoviesOrSeries(_searchTerm, 'fc05eb53') as Future<List>?;
    });
  } else {
    
  }
  }
  
  void _loadMoreMovies() async {
    _currentPage++;

    final nextPageResults = await searchMoviesOrSeries(_searchTerm, 'fc05eb53', page: _currentPage);
     print(nextPageResults);
    // Update _searchResults to include new results
     /*setState(() {
      if (nextPageResults['Response'] == 'True' && nextPageResults['Search'] != null) {
        final newMovies = nextPageResults['Search'];
        _searchResults?.then((currentResults) {
            final combinedResults = [...currentResults, ...newMovies];
 // Combine results 
          
    }); 
   }
     }); */
  }

  List<Widget> buildMovieList(List<dynamic>movies) {
    return movies.map((movie) => //bch ncreew widget lkol movie
      GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie :movie),
            ),
        ),
        child: ListTile(
          leading: movie['Poster'] != 'N/A' // ... // Check for poster availability
            ? Image.network(movie['Poster'])
            : null,// Display placeholder if no post
         title: Text(movie['Title']),
         subtitle: Text(movie['Year']),
      ),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche de films/serie'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchTermController,
            decoration:
                const InputDecoration(hintText: 'Entrez votre Recherche'),
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: _searchTerm.isNotEmpty ? _onSearch : null,
            child: const Text('Rechercher'),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Process and display search results
                  final jsonData = snapshot.data;
                  if (jsonData['Response'] == 'True' &&
                      jsonData['Search'] != null) {
                    //process search results
                    final List<dynamic> movies = jsonData['Search'];
                    final movieListWidgets = buildMovieList(movies);
                    return Column(
                      children: [
                        ListView.builder(
                      shrinkWrap: true, 
                      itemCount: movies.length,
                      itemBuilder: (context, index) => movieListWidgets[index],
                    ),
                             // Add button to load more movies only if there might be more results
                    if (jsonData['TotalResults'] != 'N/A' && int.parse(jsonData['TotalResults']) > movies.length)
                      ElevatedButton(
                        onPressed: _loadMoreMovies,
                        child: const Text('Charger plus de films'),
                     ),
                      ],
                    );


                  } else {
                    // Handle unsuccessful response or missing data
                  }
                    return const Text('Aucun résultat trouvé.');
                  } 
                else if (snapshot.hasError) {
                 return Text('Erreur: ${snapshot.error}');
              } else {
                 return const Center(child: CircularProgressIndicator());

              }
            },
          ),
        ),
      ],
    ),
    );
  }
  }

