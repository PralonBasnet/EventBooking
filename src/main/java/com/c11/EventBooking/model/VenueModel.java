package com.c11.EventBooking.model;

import java.io.Serializable;

//POJO for the {@code venue} table. */
public class VenueModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    venueID;
    private String venueName;
    private int    venueCapacity;
    private String venueContact;
    private String venueAddress;

    public VenueModel() {}

    public int getVenueID()                  { return venueID; }
    public void setVenueID(int v)            { this.venueID = v; }

    public String getVenueName()             { return venueName; }
    public void setVenueName(String v)       { this.venueName = v; }

    public int getVenueCapacity()            { return venueCapacity; }
    public void setVenueCapacity(int v)      { this.venueCapacity = v; }

    public String getVenueContact()          { return venueContact; }
    public void setVenueContact(String v)    { this.venueContact = v; }

    public String getVenueAddress()          { return venueAddress; }
    public void setVenueAddress(String v)    { this.venueAddress = v; }
}
