package de.teama.bl.data;

import org.json.JSONObject;

public class Link {
    private String name;
    private String url;

    public Link(String name, String url) {
        this.name = name;
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }

    @Override
    public String toString() {
        return new JSONObject(this).toString();
    }
}
