package com.c11.EventBooking.util;

import org.mindrot.jbcrypt.BCrypt;

/** BCrypt password utility. */
public class PasswordUtils {

    // 10 rounds (2^10 iterations) — standard cost factor for BCrypt
    private static final int COST = 10;

    public static String getHashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(COST));
    }

    public static boolean checkPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, storedHash);
    }
}
