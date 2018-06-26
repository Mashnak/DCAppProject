class ArtistData {
  ArtistData(
      this.name,
      this.genres,
      this.tags, // this.songs,
      this.albums,
      this.imagePath);

  final String name;
  final List genres;
  final List tags;
  // final List songs;
  final List albums;
  final String imagePath;

  ArtistData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        genres = json['genre'],
        tags = json['tag'],
        albums = json['albums'],
        imagePath = json['img'];
}
