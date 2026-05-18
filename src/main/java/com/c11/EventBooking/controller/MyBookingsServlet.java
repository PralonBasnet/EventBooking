package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.BookingDAO;
import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Shows the logged-in user's booking history.
 */
@WebServlet("/MyBookings")
public class MyBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(MyBookingsServlet.class.getName());

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtils.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        try {
            request.setAttribute("bookings",
                    bookingDAO.getBookingsByUser(user.getUserID()));
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to load bookings for user", e);
            request.setAttribute("bookingsError", "Could not load your bookings.");
        }

        request.getRequestDispatcher("/WEB-INF/views/user/myBookings.jsp")
               .forward(request, response);
    }
}
