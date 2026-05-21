package com.c11.EventBooking.util;

import com.c11.EventBooking.model.UserModel;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/** Centralized session helper. */
public class SessionUtils {

    public static final String USER_KEY = "user";

    private SessionUtils() {}

    public static void createUserSession(HttpServletRequest request, UserModel user) {
        // Invalidate old session to prevent session fixation
        HttpSession old = request.getSession(false);
        if (old != null) {
            old.invalidate();
        }
        HttpSession session = request.getSession(true);
        session.setAttribute(USER_KEY, user);
        session.setMaxInactiveInterval(30 * 60); // 30 minutes per web.xml
    }

    public static UserModel getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (UserModel) session.getAttribute(USER_KEY);
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getLoggedInUser(request) != null;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        UserModel user = getLoggedInUser(request);
        return user != null && "ADMIN".equalsIgnoreCase(user.getUserRole());
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
