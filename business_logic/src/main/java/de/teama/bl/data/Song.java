package de.teama.bl.data;

import org.springframework.data.annotation.Id;

public class Song {
  @Id
  private String id;

  private String name;
  private String length;
  private String releaseDate; // TODO: turn into DateTime?

  private String publisher;
  private String album;

  public Song(String name, String length, String releaseDate, String publisher, String album){

    this.name = name;
    this.length = length;
    this.releaseDate = releaseDate; // TODO: turn into DateTime?

    this.publisher = publisher;
    this.album = album;
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

  public String getPublisher() {
    return publisher;
  }

  public String getAlbum() {
    return album;
  }
}
