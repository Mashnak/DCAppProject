package de.teama.bl.data;

import java.util.List;

public class Album {
  private String id;

  private String name;
  private String totalLength;
  private String genre;
  private String releaseDate; // TODO: turn into DateTIme?

  private List<Song> songs;

  private Publisher publisher;
  private Artist artist;

  public Album(String name){
    this.name = name;
  }

  @Override
  public String toString() {
    return name;
  }
}
