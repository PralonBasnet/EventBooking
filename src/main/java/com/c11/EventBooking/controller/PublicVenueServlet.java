package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.VenueDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Loads all venues for the public venues pages. */
@WebServlet("/Venues")
public class PublicVenueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final VenueDAO venueDAO = new VenueDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("venues", venueDAO.getAllVenues());
        } catch (Exception e) {
            request.setAttribute("venuesError", "Could not load venues.");
        }
        request.getRequestDispatcher("/WEB-INF/views/public/venues.jsp")
               .forward(request, response);
    }
}
