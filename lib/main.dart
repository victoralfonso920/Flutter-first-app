import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: RandowWords(),
    );
  }
}

class RandowWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandowWordsSate();
  }
}

class RandowWordsSate extends State<RandowWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Flutter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        final tiles = _saved.map((_suggestions){
          return ListTile(
            title: Text(
              _suggestions.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
        ).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(
            children: divided,
          ),
        );
      })
    );
  }
  //widget lista
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider();
        }
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final index = i ~/ 2;
        return _buildRow(_suggestions[index]);
      },
    );
  }

//celda de lista
  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(suggestion);
          }else{
            _saved.add(suggestion);
          }
        });
      },
    );
  }
}