package de.teama.bl.data;

import org.springframework.data.annotation.Id;

public class User {
    @Id
    private String ID;

    private String name;

    public User(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}
