package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Album {
    @Id @Indexed @TextIndexed
    private String name;
    @Indexed
    private String releaseDate;

    private String genre;
    private String publisher;
    private String tag;

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
