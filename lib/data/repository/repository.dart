import 'package:music_app/data/src/source.dart';

import '../models/song.dart';

abstract class Repository {
  Future<List<Song>?> fetchSongs();

}

class DefaultRepository implements Repository {
  final remoteDataSource = RemoteDataSoruce();
  final localDataSource = LocalDataSoruce();
  @override
  Future<List<Song>?> fetchSongs() async{
    List<Song>? songs = [];
    await remoteDataSource.fetchSongs().then((remoteSongs) {
      if(remoteSongs == null){
        localDataSource.fetchSongs().then((localSong) {
          if(localSong != null){
            songs.addAll(localSong);
          }
        });
      }else{
        songs.addAll(remoteSongs);
      }
    });
    return songs;
  }


}