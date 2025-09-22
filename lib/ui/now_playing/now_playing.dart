import 'package:flutter/material.dart';
import 'package:music_app/data/models/song.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key, required this.song, required this.songs});
  final Song song;
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return NowPlayingPageScreen(song: song, songs: songs);
  }
}

class NowPlayingPageScreen extends StatefulWidget {
  const NowPlayingPageScreen({super.key, required this.song, required this.songs});
  final Song song;
  final List<Song> songs;
  @override
  State<NowPlayingPageScreen> createState() => _NowPlayingPageScreenState();
}

class _NowPlayingPageScreenState extends State<NowPlayingPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Now Playing Screen'),
      ),
    );
  }
}