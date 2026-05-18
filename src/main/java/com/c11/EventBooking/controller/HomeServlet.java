package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Loads the home page with popular events. */
@WebServlet("/Home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(HomeServlet.class.getName());

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<String[]> popular = bookingDAO.getMostBookedEvents();
            request.setAttribute("popularEvents", popular);
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Could not load popular events", e);
        }
        request.getRequestDispatcher("/WEB-INF/views/user/home.jsp")
               .forward(request, response);
    }
}
