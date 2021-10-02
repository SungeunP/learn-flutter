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
          final tiles = _saved.map( // Create tiles by `_saved` state
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
            tiles: tiles, // Created tiles
          ).toList(); // Transform to list

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided), // Append ListTiles to ListView widget
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

class MyApp extends StatelessWidget { // StatelessWidget을 상속함, 앱 자체를 위젯으로 만듦, 플러터에서는 모든 것이 위젯임 (정렬, 패딩, 레이아웃 ..)
  @override
  Widget build(BuildContext context) { // Widget의 주 역할은 다른 하위 수준의 위젯들과 관련해서 위젯을 어떻게 표시해야 하는지를 설명하는 방법을 제공하는 것임
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(), // Set home suggestion name list
    );
  }
}