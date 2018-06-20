package de.teama.bl;

/*
 * AliveStatus-Objekt, was im JSON-Format den Alive-Status eines Microservices zurueckgibt.  
 * Gruppe D
 * 		Christian Brenner
 * 		Jaqueline Patzek
 */


public class AliveStatus {

    // Konstanten fuer verschiedene ON-/OFF-Status 
    // prinzipiell um weitere Zustaende erweiterbar
	public final static int STATUS_OFFLINE = 0;
	public final static int STATUS_ONLINE = 1;

    public String msID;
    public String appID;
    public String eventUrl;
	public int noOfUser;
	public int status;
    
    public AliveStatus() {}
    
    public AliveStatus(String id) {
        this.appID = id;

    }

	public String getMsID() {
		return msID;
	}

	public void setMsID(String msID) {
		this.msID = msID;
	}

	public String getAppID() {
		return appID;
	}

	public void setAppID(String appID) {
		this.appID = appID;
	}

	public String getEventUrl() {
		return eventUrl;
	}

	public void setEventUrl(String eventUrl) {
		this.eventUrl = eventUrl;
	}

	public int getNoOfUser() {
		return noOfUser;
	}

	public void setNoOfUser(int noOfUser) {
		this.noOfUser = noOfUser;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
    

    
}

