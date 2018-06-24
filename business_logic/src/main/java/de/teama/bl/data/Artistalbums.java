package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Artistalbums {
    @Id
    private String _id;

    private String artist;
    private String album;

    public Artistalbums(String artist, String album) {
        this.artist = artist;
        this.album = album;
    }

    public String get_id() {
        return _id;
    }

    public String getArtist() {
        return artist;
    }

    public String getAlbum() {
        return album;
    }
}
