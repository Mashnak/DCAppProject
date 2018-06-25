package de.teama.bl;

public class HeartbeatObject {
    private String eventName;
    private String description;
    private boolean errorTag;
    private String microserviceID;
    private String appID;
    private String timestamp;

    public HeartbeatObject(String eventName, String description, boolean errorTag, String microserviceID, String appID, String timestamp) {
        this.eventName = eventName;
        this.description = description;
        this.errorTag = errorTag;
        this.microserviceID = microserviceID;
        this.appID = appID;
        this.timestamp = timestamp;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isErrorTag() {
        return errorTag;
    }

    public void setErrorTag(boolean errorTag) {
        this.errorTag = errorTag;
    }

    public String getMicroserviceID() {
        return microserviceID;
    }

    public void setMicroserviceID(String microserviceID) {
        this.microserviceID = microserviceID;
    }

    public String getAppID() {
        return appID;
    }

    public void setAppID(String appID) {
        this.appID = appID;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
