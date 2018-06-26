class AlbumData {
  AlbumData(this.name, this.releaseDate, this.genres, this.tags, this.songs,
      this.artists, this.imagePath);

  final String name;
  final DateTime releaseDate;
  final List genres;
  final List tags;
  final List songs;
  final List artists;
  final String imagePath;

  AlbumData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = DateTime.parse(json['releaseDate']),
        genres = json['genre'],
        tags = json['tag'],
        songs = json['songs'],
        artists = json['artists'],
        imagePath = json['img'];
}
