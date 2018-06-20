package de.teama.bl.data;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class ArtistAlbum {
    private String artist;
    private String album;

    public ArtistAlbum(String artist, String album) {
        this.artist = artist;
        this.album = album;
    }

    public String getArtist() {
        return artist;
    }

    public String getAlbum() {
        return album;
    }
}
