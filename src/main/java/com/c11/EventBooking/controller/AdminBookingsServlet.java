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

// Handles admin view and status updates for bookings. 
@WebServlet("/admin/bookings")
public class AdminBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(AdminBookingsServlet.class.getName());

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            java.util.List<com.c11.EventBooking.model.Booking> bookings = bookingDAO.getAllBookings();
            request.setAttribute("bookings",      bookings);
            request.setAttribute("bookingCount",  bookings.size());
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to load all bookings for admin", e);
            request.setAttribute("bookingsError", "Could not load bookings.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/manageBookings.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action     = request.getParameter("action");
        String idStr      = request.getParameter("bookingID");

        try {
            int bookingID = Integer.parseInt(idStr);
            if ("confirm".equals(action)) {
                bookingDAO.updateBookingStatus(bookingID, "CONFIRMED");
            } else if ("markPaid".equals(action)) {
                bookingDAO.updatePaymentStatus(bookingID, "PAID");
            } else if ("cancel".equals(action)) {
                bookingDAO.updateBookingStatus(bookingID, "CANCELLED");
            } else if ("cancelRefund".equals(action)) {
                bookingDAO.cancelAndRefund(bookingID);
            }
            response.sendRedirect(request.getContextPath() + "/admin/bookings?success=" + action);
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to update booking status", e);
            response.sendRedirect(request.getContextPath() + "/admin/bookings?error=update_failed");
        }
    }
}
