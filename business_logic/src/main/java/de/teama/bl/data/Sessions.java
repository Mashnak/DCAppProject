package de.teama.bl.data;

import java.util.HashSet;
import java.util.LinkedList;

public class Sessions extends Users {

    public Sessions(String name, String password, String birthdate, boolean isAdmin){
        this.name = name;
        this.password = password;
        this.birthdate = birthdate;
        this.friends = new HashSet<>();
        this.playlists = new LinkedList<>();
        this.isAdmin = isAdmin;
    }
}
