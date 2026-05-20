package com.c11.EventBooking.model;

import java.io.Serializable;

// POJO for the table
public class UserModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    userID;
    private String fullName;
    private String userName;
    private String contactNumber;
    private String email;
    private String userStatus;
    private String userRole;
    private String password;
    private String profilePicture;

    // stored as String in YYYY-MM-DD format; avoids java.sql.Date conversion overhead
    private String dateOfBirth;

    public UserModel() {}

    public int getUserID()                      { return userID; }
    public void setUserID(int userID)           { this.userID = userID; }

    public String getFullName()                 { return fullName; }
    public void setFullName(String v)           { this.fullName = v; }

    public String getUserName()                 { return userName; }
    public void setUserName(String v)           { this.userName = v; }

    public String getContactNumber()            { return contactNumber; }
    public void setContactNumber(String v)      { this.contactNumber = v; }

    public String getEmail()                    { return email; }
    public void setEmail(String v)              { this.email = v; }

    public String getUserStatus()               { return userStatus; }
    public void setUserStatus(String v)         { this.userStatus = v; }

    public String getUserRole()                 { return userRole; }
    public void setUserRole(String v)           { this.userRole = v; }

    public String getPassword()                 { return password; }
    public void setPassword(String v)           { this.password = v; }

    public String getProfilePicture()           { return profilePicture; }
    public void setProfilePicture(String v)     { this.profilePicture = v; }

    public String getDateOfBirth()              { return dateOfBirth; }
    public void setDateOfBirth(String v)        { this.dateOfBirth = v; }
}
