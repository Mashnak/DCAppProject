package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Comments {

    @Id
    private String _id;

    private String text;
    private String user;
    private String timestamp;
    private String related;
    private String answerRef;

    public Comments(String text, String user, String timestamp, String related, String answerRef) {
        this.text = text;
        this.user = user;
        this.timestamp = timestamp;
        this.related = related;
        this.answerRef = answerRef;
    }

    public String get_id() {
        return _id;
    }

    public String getText() {
        return text;
    }

    public String getUser() {
        return user;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public String getRelated() {
        return related;
    }

    public String getAnswerRef() {
        return answerRef;
    }
}
