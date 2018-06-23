package de.teama.bl.data;

import org.json.JSONObject;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.index.TextIndexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;


@Document
public class Artists {
    @Id
    private String _id;

    private String name;

    private List<String> genre;
    private List<String> tag;
    private String img;

    public String get_id() {
        return _id;
    }

    @Override
    public String toString(){
        return new JSONObject(this).toString();
    }

    public String getName() {
        return name;
    }

    public List<String> getGenre() {
        return genre;
    }

    public List<String> getTag() {
        return tag;
    }

    public String getImg() {
        return img;
    }
}
