package com.c11.EventBooking.model;

import java.io.Serializable;

// POJO for the table. 
public class Booking implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    bookingID;
    private int    userID;
    private int    eventID;
    private String bookingStatus;
    private String bookingDate;
    private double totalAmount;
    private String paymentStatus;

    // display-only, populated from JOIN; not in the booking table
    private String eventType;
    private String eventDate;
    private String eventTime;
    private String venueName;
    private String customerName;

    public Booking() {}

    public int    getBookingID()              { return bookingID; }
    public void   setBookingID(int v)         { this.bookingID = v; }

    public int    getUserID()                 { return userID; }
    public void   setUserID(int v)            { this.userID = v; }

    public int    getEventID()                { return eventID; }
    public void   setEventID(int v)           { this.eventID = v; }

    public String getBookingStatus()          { return bookingStatus; }
    public void   setBookingStatus(String v)  { this.bookingStatus = v; }

    public String getBookingDate()            { return bookingDate; }
    public void   setBookingDate(String v)    { this.bookingDate = v; }

    public double getTotalAmount()            { return totalAmount; }
    public void   setTotalAmount(double v)    { this.totalAmount = v; }

    public String getPaymentStatus()          { return paymentStatus; }
    public void   setPaymentStatus(String v)  { this.paymentStatus = v; }

    public String getEventType()              { return eventType; }
    public void   setEventType(String v)      { this.eventType = v; }

    public String getEventDate()              { return eventDate; }
    public void   setEventDate(String v)      { this.eventDate = v; }

    public String getEventTime()              { return eventTime; }
    public void   setEventTime(String v)      { this.eventTime = v; }

    public String getVenueName()              { return venueName; }
    public void   setVenueName(String v)      { this.venueName = v; }

    public String getCustomerName()           { return customerName; }
    public void   setCustomerName(String v)   { this.customerName = v; }
}