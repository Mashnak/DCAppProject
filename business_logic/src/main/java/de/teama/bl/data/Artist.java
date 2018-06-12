package de.teama.bl.data;

import org.springframework.data.annotation.Id;

import java.util.List;

public class Artist {
    @Id
    private String id;
    private String name;

    private String genre;

    private List<Song> songs;
    private List<Album> albums;
    private List<Publisher> publishers;

    public Artist(String name, String genre) {
        this.name = name;
        this.genre = genre;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getGenre() {
        return genre;
    }

    public List<Song> getSongs() {
        return songs;
    }

    public List<Album> getAlbums() {
        return albums;
    }

    public List<Publisher> getPublishers() {
        return publishers;
    }
}
