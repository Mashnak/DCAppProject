package de.teama.bl.data;

import org.json.JSONObject;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class Songs {
    @Id
    private String _id;

    private String name;

    private String length;
    private String releaseDate;
    private String lyrics;
    private List<Link> link;
    private List<String> genre;
    private List<String> tag;
    private String img;
    private String album;

    public Songs(String name, String length, String releaseDate, String lyrics, List<Link> link,
                 List<String> genre, List<String> tag, String img, String album) {
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

    public String get_id() {
        return _id;
    }

    public String getName() {
        return name;
    }

    public String getLength() {
        String formattedLength = "";
        try {
            int lengthInt = Integer.parseInt(this.length);
            formattedLength += (lengthInt/60000);       //milliseconds to minutes
            formattedLength += ":";                     //colon divider
            formattedLength += ((lengthInt%60000)/1000);//rest of milliseconds to seconds
        }catch (NumberFormatException e){
            return this.length;
        }
        return formattedLength;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public String getLyrics() {
        return lyrics;
    }

    public List<Link> getLink() {
        return this.link;
    }

    public void addLink(String name, String url){
        link.add(new Link(name, url));
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
