package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

@Document
public class Users {
    @Id @Indexed @TextIndexed
    private String name;

    private String password;
    private String birthdate;
    private Set<String> friends;
    private List<String> playlists;
    private boolean isAdmin;

    public Users(String name, String password, String birthdate, boolean isAdmin) {
        this.name = name;
        this.password = password;
        this.birthdate = birthdate;
        this.friends = new HashSet<>();
        this.playlists = new LinkedList<>();
        this.isAdmin = isAdmin;
    }

    public String getPassword() {
        return password;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public List<String> getFriends() {
        List<String> friends = new LinkedList<>();
        friends.addAll(this.friends);
        return friends;
    }
    public void addFriend(String friend) {
        this.friends.add(friend);
    }

    public List<String> getPlaylists() {
        return playlists;
    }

    public boolean isAdmin() {
        return isAdmin;
    }


    public Users(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}
