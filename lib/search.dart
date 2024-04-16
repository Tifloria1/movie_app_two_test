import 'package:http/http.dart' as http;
import 'dart:convert'; // Import the dart:convert library


Future<List<dynamic>?> searchMoviesOrSeries(
  String searchTerm,
  String apiKey, {
  int page = 1,
}) async {
  final url = 'http://www.omdbapi.com/?apikey=$apiKey&s=$searchTerm';
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData; // Return jsonData when response is successful
    } else {
      // Handle error response (e.g., show an error message)
      throw Exception('Failed to fetch movies: Status code ${response.statusCode}');
    }
  } catch (error) {
    print(error); // Log the error for debugging
    return null; // Return null on error
  }
}
  