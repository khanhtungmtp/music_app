import 'package:flutter/material.dart';
import 'package:music_app/data/repository/repository.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var repository = DefaultRepository();
  var songs = await repository.fetchSongs();
  for(var song in songs!){
    debugPrint(song.toString());
  }
  // runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
