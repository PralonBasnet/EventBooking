package com.c11.EventBooking.service;

/** Thrown when a PENDING-status account attempts to log in. */
public class AccountPendingException extends Exception {

    public AccountPendingException(String message) {
        super(message);
    }
}
