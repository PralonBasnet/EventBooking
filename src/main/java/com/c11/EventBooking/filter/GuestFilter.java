package com.c11.EventBooking.filter;

import com.c11.EventBooking.util.SessionUtils;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Redirects already-logged-in users away from the login and register pages. */
public class GuestFilter extends HttpFilter {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doFilter(HttpServletRequest request,
                            HttpServletResponse response,
                            FilterChain chain)
            throws IOException, ServletException {

        if (SessionUtils.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/Home");
            return;
        }

        chain.doFilter(request, response);
    }
}
