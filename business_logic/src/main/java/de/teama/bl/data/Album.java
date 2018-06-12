package de.teama.bl.data;

import org.springframework.data.annotation.Id;

import java.util.List;

public class Album {
    @Id
    private String id;

    private String name;
    private String totalLength;
    private String genre;
    private String releaseDate; // TODO: turn into DateTIme?

    private List<Song> songs;

    private Publisher publisher;
    private Artist artist;

    public Album(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getTotalLength() {
        return totalLength;
    }

    public String getGenre() {
        return genre;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public List<Song> getSongs() {
        return songs;
    }

    public Publisher getPublisher() {
        return publisher;
    }

    public Artist getArtist() {
        return artist;
    }

    @Override
    public String toString() {
        return name;
    }
}
