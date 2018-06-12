package de.teama.bl.data;

import org.springframework.data.annotation.Id;

public class Publisher {
    @Id
    private String id;

    private String name;

    public Publisher(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }
}
