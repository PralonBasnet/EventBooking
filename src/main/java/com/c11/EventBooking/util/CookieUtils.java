package com.c11.EventBooking.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Cookie read/write helpers. */
public class CookieUtils {

    private CookieUtils() {}

    public static void setCookie(HttpServletResponse resp, String name,
                                 String value, int maxAgeSeconds) {
        Cookie c = new Cookie(name, value);
        c.setMaxAge(maxAgeSeconds);
        c.setPath("/");
        c.setHttpOnly(true);
        resp.addCookie(c);
    }

    // Returns null if the cookie is not present
    public static String getCookie(HttpServletRequest req, String name) {
        if (req.getCookies() == null) return null;
        for (Cookie c : req.getCookies()) {
            if (name.equals(c.getName())) return c.getValue();
        }
        return null;
    }

    public static void deleteCookie(HttpServletResponse resp, String name) {
        Cookie c = new Cookie(name, "");
        c.setMaxAge(0);
        c.setPath("/");
        resp.addCookie(c);
    }
}
