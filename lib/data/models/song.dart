class Song {
  final String id;
  final String title;
  final String album;
  final String artist;
  final String source;
  final String image;
  final int duration;

  Song({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.source,
    required this.image,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      source: json['source'] as String,
      image: json['image'] as String,
      duration: json['duration'] as int,
    );
  }

  /// Để so sánh hai đối tượng Song dựa trên thuộc tính id (vì ID là duy nhất), 
  /// giúp kiểm tra xem hai bài hát có phải là một hay không một cách hiệu quả trong các cấu trúc dữ liệu như Set hoặc Map.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Song && runtimeType == other.runtimeType && other.id == id);
  }

  @override
  int get hashCode => super.hashCode;
}
