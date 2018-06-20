package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;


@Document
public class Artist {
//    @Id
//    private String id;
    @Id @Indexed
    private String name;

    private List<String> genre;
    private List<String> tag;

    public Artist(String name, String genre, String tag) {
        this.name = name;
        this.genre.add(genre);
        this.tag.add(tag);
    }

//    public String getId() {
//        return id;
//    }

    public String getName() {
        return name;
    }

    public List<String> getGenre() {
        return genre;
    }

    public List<String> getTag() {
        return tag;
    }
}
