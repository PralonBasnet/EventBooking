package com.c11.EventBooking.filter;

import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.SessionUtils;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Guards authenticated routes and enforces role-based access. */
public class AuthenticationFilter extends HttpFilter {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doFilter(HttpServletRequest request,
                            HttpServletResponse response,
                            FilterChain chain)
            throws IOException, ServletException {

        // must be logged in
        if (!SessionUtils.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        // account must still be ACTIVE
        UserModel user = SessionUtils.getLoggedInUser(request);
        if (!"ACTIVE".equalsIgnoreCase(user.getUserStatus())) {
            SessionUtils.invalidateSession(request);
            response.sendRedirect(request.getContextPath() + "/Login?suspended=true");
            return;
        }

        // admin area requires ADMIN role
        String uri = request.getRequestURI();
        if (uri.contains("/admin/") && !SessionUtils.isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }

        // all checks passed
        chain.doFilter(request, response);
    }
}
