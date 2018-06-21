package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.LinkedList;
import java.util.List;

@Document
public class Playlist {

    @Id
    private String id;

    private String name;
    private String creationDate;
    private List<String> songs;

    public Playlist(String name, String creationDate) {
        this.name = name;
        this.creationDate = creationDate;
        this.songs = new LinkedList<>();
    }

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
