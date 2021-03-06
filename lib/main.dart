import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class RandomWords extends StatefulWidget { // RandomWords StatefulWidget
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> { // State of RandomWords StatefulWidget
  final _suggestions = <WordPair>[]; // WordPair items
  final _saved = <WordPair>{}; // Saved WordPair items
  final _biggerFont = const TextStyle(fontSize: 18.0); // Font size

  // Push route to Navigator
  void _pushSaved() {
    Navigator.of(context).push( // Push route
      MaterialPageRoute<void>( // Page Route
        builder: (BuildContext context) {
          var bodyContent = null;
          if (_saved.length <= 0) { // Set empty placeholder when saved is not exist
            bodyContent = Center(
                child: Text(
                    'Not exist saved startup name',
                  textAlign: TextAlign.center,
                  style: _biggerFont,
                ),
            );
          } else {
            final listTiles = _saved.map( // Create tiles by `_saved` state
                    (WordPair pair) {
                  return ListTile( // Simple text ListTile
                      title: Text(
                        pair.asPascalCase,
                        style: _biggerFont,
                      )
                  );
                }
            );

            final divided = ListTile.divideTiles( // Set 'Divided ListTiles'
              context: context,
              tiles: listTiles, // Created tiles
            ).toList(); // Transform to list

            bodyContent = ListView(children: divided);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: bodyContent, // Append ListTiles to ListView widget
          );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) { // Return WordPair
    return Scaffold( // Return Scaffold
      appBar: AppBar(
        title: const Text('Startup Name generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ]
      ),
      body: _buildSuggestions(), // Set body as suggestion name list
    );
  }

  // Row of suggestion name list
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair); // Is saved word pair state
    return ListTile(
      title: Text(
        pair.asPascalCase, // Default parameter
        style: _biggerFont, // Apply font size
      ),
      trailing: Icon( // Add icon to right side
        alreadySaved ? Icons.favorite : Icons.favorite_border, // Display icon by alreadySaved state
        color: alreadySaved ? Colors.red : null, // Set color by already state
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) { // If alreadySaved state is ture
            _saved.remove(pair); // Then, Remove this word pair from _saved Set
          } else { // If alreadySaved state if false
            _saved.add(pair); // Then, Add this word pair to _saved Set
          }
        });
      },
    );
  }

  // Suggestion name list
  Widget _buildSuggestions() {
    return ListView.builder( // Return ListView
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) { // This function called when row(ListTile) be visible or prepared in ListView Widget height scope
        if (i.isOdd) { // When index is odd then, add divider ex) [item, div, item, div, item, div ...]
          return const Divider();
        }

        final index = i ~/ 2; // Get index of 'only' items (index interfere with divider)
        if (index >= _suggestions.length) { // If last item then, add 10 word pairs from generateWordPairs function to _suggestions
          _suggestions.addAll(generateWordPairs().take(10)); // Add word pairs
        }

        return _buildRow(_suggestions[index]); // Return ListTile
      }
    );
  }
}

void main() => runApp(MyApp()); // Use arrow notation, One-line (no-wrap)

class MyApp extends StatelessWidget { // StatelessWidget??? ?????????, ??? ????????? ???????????? ??????, ?????????????????? ?????? ?????? ????????? (??????, ??????, ???????????? ..)
  @override
  Widget build(BuildContext context) { // Widget??? ??? ????????? ?????? ?????? ????????? ???????????? ???????????? ????????? ????????? ???????????? ???????????? ???????????? ????????? ???????????? ??????
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Set theme color
      ),
      home: RandomWords(), // Set home suggestion name list
    );
  }
}