package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class Playlist {

    @Id @Indexed @TextIndexed
    private String id;

    private String name;
    private String creationDate;
    private List<String> songs;

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public List<String> getSongs() {
        return songs;
    }
}
