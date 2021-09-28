import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget { // RandomWords StatefulWidget
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> { // State of RandomWords StatefulWidget
  @override
  Widget build(BuildContext context) { // Return WordPair
    final wordPair = WordPair.random(); // Get word pair
    return Text(wordPair.asPascalCase); // Return Text component with word pair
  }
}

void main() => runApp(MyApp()); // Use arrow notation, One-line (no-wrap)

class MyApp extends StatelessWidget { // StatelessWidget을 상속함, 앱 자체를 위젯으로 만듦, 플러터에서는 모든 것이 위젯임 (정렬, 패딩, 레이아웃 ..)
  @override
  Widget build(BuildContext context) { // Widget의 주 역할은 다른 하위 수준의 위젯들과 관련해서 위젯을 어떻게 표시해야 하는지를 설명하는 방법을 제공하는 것임
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold( // Scaffold, Material library, app bar와 홈 화면의 위젯 트리를 보유한 속성을 제공해줌
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center( // Center가 Text를 포함하고 있음, 그러하여 Text는 화면 중앙으로 정렬됨 (+ const는 런타임중에 변수를 할당할 수 없어, const keyword는 삭제되었음)
          child: RandomWords(), // Display random word pair
        ),
      ),
    );
  }
}