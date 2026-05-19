package com.c11.EventBooking.model;

import java.io.Serializable;

// POJO for the {@code event} table. 
public class EventModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    eventID;
    private int    venueID;
    private String eventType;
    private double eventPrice;
    private String eventDate;
    private String eventTime;
    private String venueName;   // display-only, from JOIN

    public EventModel() {}

    public int getEventID()                    { return eventID; }
    public void setEventID(int v)              { this.eventID = v; }

    public int getVenueID()                    { return venueID; }
    public void setVenueID(int v)              { this.venueID = v; }

    public String getEventType()               { return eventType; }
    public void setEventType(String v)         { this.eventType = v; }

    public double getEventPrice()              { return eventPrice; }
    public void setEventPrice(double v)        { this.eventPrice = v; }

    public String getEventDate()               { return eventDate; }
    public void setEventDate(String v)         { this.eventDate = v; }

    public String getEventTime()               { return eventTime; }
    public void setEventTime(String v)         { this.eventTime = v; }

    public String getVenueName()               { return venueName; }
    public void setVenueName(String v)         { this.venueName = v; }
}
