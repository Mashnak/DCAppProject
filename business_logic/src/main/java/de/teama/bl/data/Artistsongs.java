package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Artistsongs {
    @Id
    private String _id;

    private String artist;
    private String song;

    public Artistsongs(String artist, String song) {
        this.artist = artist;
        this.song = song;
    }

    public String get_id() {
        return _id;
    }

    public String getArtist() {
        return artist;
    }

    public String getSong() {
        return song;
    }
}
