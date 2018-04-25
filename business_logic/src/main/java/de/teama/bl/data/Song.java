package de.teama.bl.data;

public class Song {
  private String id;

  private String name;
  private String length;
  private String releaseDate; // TODO: turn into DateTime?

  private Publisher publisher;
  private Album album;

  public Song(String id, String name, String length, String releaseDate, String publisherName, String albumName){
    this.id =  id;

    this.name = name;
    this.length = length;
    this.releaseDate = releaseDate; // TODO: turn into DateTime?

    this.publisher = new Publisher(publisherName);
    this.album = new Album(albumName);
  }

  @Override
  public String toString() {
    return name;
  }

  public String getId() {
    return id;
  }

  public String getName() {
    return name;
  }

  public String getLength() {
    return length;
  }


  public String getReleaseDate() {
    return releaseDate;
  }

  public Publisher getPublisher() {
    return publisher;
  }

  public Album getAlbum() {
    return album;
  }
}
