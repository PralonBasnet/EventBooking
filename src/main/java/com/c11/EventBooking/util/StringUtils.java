package com.c11.EventBooking.util;

/** Shared the string helpers. */
public final class StringUtils {

    private StringUtils() {}

    // null-safe: String.isBlank() throws NullPointerException on null inputs
    public static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }
}
