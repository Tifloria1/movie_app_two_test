class Favorite {
  final int id;
  final String title;
  final String posterURL;
  final String overview;
  final String year ;
  final String mediaType;
 


  Favorite({
    
    
    required this.id,
    required this.title,
    required this.posterURL,
    required this.overview,
    required this.mediaType,
    required this.year,
    
  });

  factory Favorite.fromMap(Map<String, dynamic> map) => Favorite(
    id: map['id'] as int, // Assuming 'id' exists in the map
    title: map['title'] as String,
    posterURL: map['posterURL'] as String,
    overview: map['overview'] as String,
    mediaType: map['mediaType'] as String,
    year: map['year'] as String, // Assuming 'year' exists in the map

  );
}

