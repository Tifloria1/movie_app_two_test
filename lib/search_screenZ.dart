import 'package:flutter/material.dart';


class _SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchScreen> {
  String _searchTerm = '';

@override 
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar (
      title: const Text('Recherche de films/Series'),
    ),
    body : Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Rechercher',
          ),
          onChanged: (Text) {
            setState(() {
              _searchTerm = Text;
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            // had button bch nsearchiw film/Series with _searchTerm

          },
          child: const Text('Rechercher'),
        ),
      ],
      ),
    );
  }
}