package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Album {
//    @Id
//    private String id;
    @Id @Indexed
    private String name;
    @Indexed
    private String releaseDate;

    private String genre;
    private String publisher;
    private String tag;

    public Album(String name, String releaseDate, String genre, String publisher, String tag) {
        this.name = name;
        this.releaseDate = releaseDate;
        this.genre = genre;
        this.publisher = publisher;
        this.tag = tag;
    }

//    public String getId() {
//        return id;
//    }

    public String getName() {
        return name;
    }

    public String getGenre() {
        return genre;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public String getPublisher() {
        return publisher;
    }

    @Override
    public String toString() {
        return name;
    }
}
