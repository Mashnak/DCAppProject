package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document
public class User {
    @Id @Indexed
    private String name;

    private String password;
    private String birthdate;
    private List<String> friends;
    private List<String> playlists;
    private boolean isAdmin;

    public String getPassword() {
        return password;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public List<String> getFriends() {
        return friends;
    }

    public List<String> getPlaylists() {
        return playlists;
    }

    public boolean isAdmin() {
        return isAdmin;
    }


    public User(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}
