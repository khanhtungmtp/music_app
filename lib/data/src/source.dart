import 'dart:convert';

import '../models/song.dart';
// import package http
import 'package:http/http.dart' as http;

abstract class DataSource {
  Future<List<Song>?> fetchSongs();
}

class RemoteDataSoruce implements DataSource {
  @override
  Future<List<Song>?> fetchSongs() async {
    const url = "https://thantrieu.com/resources/braniumapis/songs.json";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final json = jsonDecode(bodyContent) as Map;
      var songsJson = json['songs'] as List;
      final songs = songsJson.map((song) => Song.fromJson(song)).toList();
      return songs;
    }
    return null;
  }
}

class LocalDataSoruce implements DataSource {
  @override
  Future<List<Song>?> fetchSongs() {
    // TODO: implement loadData
    throw UnimplementedError();
  }
}