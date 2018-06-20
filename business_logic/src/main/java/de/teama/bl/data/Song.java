package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class Song {
    @Id @Indexed
    private String name;

    private String length;
    private String releaseDate; // TODO: turn into DateTime?
    private String lyrics;
    private List<String> links;
    private String genre;
    private String tag;
    private String img;
    private String album;

    public Song(String name, String length, String releaseDate, String album) {

        this.name = name;
        this.length = length;
        this.releaseDate = releaseDate; // TODO: turn into DateTime?
        this.album = album;
    }

    @Override
    public String toString() {
        return name;
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

    public String getLyrics() {
        return lyrics;
    }

    public List<String> getLinks() {
        return links;
    }

    public String getGenre() {
        return genre;
    }

    public String getTag() {
        return tag;
    }

    public String getImg() {
        return img;
    }

    public String getAlbum() {
        return album;
    }
}
