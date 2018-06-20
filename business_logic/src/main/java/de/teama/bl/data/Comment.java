package de.teama.bl.data;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Comment {

    @Id
    private String id;

    private String text;
    private String user;
    private String timestamp;
    private String related;
    private String answerRef;

    public Comment(String text, String user, String timestamp, String related, String answerRef) {
        this.text = text;
        this.user = user;
        this.timestamp = timestamp;
        this.related = related;
        this.answerRef = answerRef;
    }

    public String getId() {
        return id;
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
