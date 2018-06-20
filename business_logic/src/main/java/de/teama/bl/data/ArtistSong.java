package de.teama.bl.data;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class ArtistSong {
    private String artist;
    private String song;

    public ArtistSong(String artist, String song) {
        this.artist = artist;
        this.song = song;
    }

    public String getArtist() {
        return artist;
    }

    public String getSong() {
        return song;
    }
}
