package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Loads booking summary data for the admin reports page. */
@WebServlet("/admin/reports")
public class ReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(ReportsServlet.class.getName());

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("totalRevenue",      bookingDAO.getTotalRevenue());
            request.setAttribute("totalBookings",     bookingDAO.getTotalBookings());
            request.setAttribute("mostPopularType",   bookingDAO.getMostPopularType());
            request.setAttribute("bookingsByStatus",  bookingDAO.getBookingsByStatus());
            request.setAttribute("bookingsPerMonth",  bookingDAO.getBookingsPerMonth());
            request.setAttribute("topEvents",         bookingDAO.getMostBookedEvents());
            request.setAttribute("eventLoadStats",    bookingDAO.getEventLoadStats());
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to load report data", e);
            request.setAttribute("reportsError", "Could not load report data.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
               .forward(request, response);
    }
}
