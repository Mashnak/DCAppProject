package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class Album {
    @Id @Indexed @TextIndexed
    private String name;

    private String releaseDate;
    private String publisher;
    private List<String> genre; //TODO List of Strings
    private List<String> tag; //TODO List of Strings
    private String img;

    public String getName() {
        return name;
    }


    public String getReleaseDate() {
        return releaseDate;
    }

    public String getPublisher() {
        return publisher;
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

    @Override
    public String toString() {
        return name;
    }
}
