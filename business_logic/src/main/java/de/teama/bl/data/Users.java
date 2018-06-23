package de.teama.bl.data;

import org.json.JSONObject;
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
    @Id
    protected String name;

    protected String password;
    protected String birthdate;
    protected Set<String> friends;
    protected List<String> playlists;
    protected boolean isAdmin;

    public Users(){

    }

    public Users(String name, String password, String birthdate, boolean isAdmin) {
        this.name = name;
        this.password = password;
        this.birthdate = birthdate;
        this.friends = new HashSet<>();
        this.playlists = new LinkedList<>();
        this.isAdmin = isAdmin;
    }

    public String toString(){
        return new JSONObject(this).toString();
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

    public String getName() {
        return name;
    }

    public Sessions createSession(){
        return new Sessions(this.name, this.password, this.birthdate, this.isAdmin);
    }


}
