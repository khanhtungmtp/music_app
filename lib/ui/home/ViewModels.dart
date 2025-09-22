import 'dart:async';

import 'package:music_app/data/models/song.dart';
import 'package:music_app/data/repository/repository.dart';

class MusicAppViewModel {
  // StreamController là một đối tượng trong Dart dùng để tạo và quản lý một luồng dữ liệu (Stream)
  StreamController<List<Song>> songStream = StreamController();
  void loadSongs() {
    final Repository repository = DefaultRepository();
    repository.fetchSongs().then(
      (song) => {
        // Cách 1: Dùng sink (cách đầy đủ)
        //songStream.sink.add(song!)
        songStream.add(song!),
      },
    );
  }
}
