package de.teama.bl.data;

import org.json.JSONObject;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class Song {
    @Id @Indexed @TextIndexed
    private String name;

    private String length;
    private String releaseDate;
    private String lyrics;
    private List<JSONObject> link;
    private List<String> genre;
    private List<String> tag;
    private String img;
    private String album;

    public Song(String name, String length, String releaseDate, String lyrics, List<JSONObject> link, List<String> genre, List<String> tag, String img, String album) {
        this.name = name;
        this.length = length;
        this.releaseDate = releaseDate;
        this.lyrics = lyrics;
        this.link = link;
        this.genre = genre;
        this.tag = tag;
        this.img = img;
        this.album = album;
    }

    @Override
    public String toString() {
        return new JSONObject(this).toString();
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

    public List<JSONObject> getLink() {
        return link;
    }

    public void addlink(String name, String url){
        JSONObject newLink = new JSONObject();
        newLink.put("name",name);
        newLink.put("url",url);
        link.add(newLink);
    }

    public List<String> getGenre() {
        return genre;
    }

    public List<String> getTag() {
        return tag;
    }

    public String getImg() {
        return img;
    }

    public String getAlbum() {
        return album;
    }
}
