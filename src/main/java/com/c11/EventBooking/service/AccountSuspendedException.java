package com.c11.EventBooking.service;

//Thrown when a SUSPENDED-status account attempts to log in
public class AccountSuspendedException extends Exception {

    public AccountSuspendedException(String message) {
        super(message);
    }
}
