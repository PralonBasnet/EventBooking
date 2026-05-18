package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.BookingDAO;
import com.c11.EventBooking.dao.EventDAO;
import com.c11.EventBooking.model.Booking;
import com.c11.EventBooking.model.EventModel;
import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Processes a user's event booking request. */
@WebServlet("/Booking")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BookingDAO bookingDAO = new BookingDAO();
    private final EventDAO   eventDAO   = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtils.getLoggedInUser(request);
        if (user == null) {
            // Should be blocked by AuthenticationFilter, but guard anyway
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String eventIDStr = request.getParameter("eventID");
        if (eventIDStr == null || eventIDStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Home?error=invalid");
            return;
        }

        try {
            int eventID = Integer.parseInt(eventIDStr);
            EventModel event = eventDAO.getEventByID(eventID);

            if (event == null) {
                response.sendRedirect(request.getContextPath() + "/Home?error=notfound");
                return;
            }

            // Build booking — totalAmount copied from event price at booking time
            Booking booking = new Booking();
            booking.setUserID(user.getUserID());
            booking.setEventID(eventID);
            booking.setTotalAmount(event.getEventPrice());
            // bookingStatus and paymentStatus defaults are set in BookingDAO.insertBooking

            int bookingID = bookingDAO.insertBooking(booking);

            // Pass booking details to the confirmation page
            request.setAttribute("event",         event);
            request.setAttribute("amount",        event.getEventPrice());
            request.setAttribute("bookingID",     bookingID);
            request.setAttribute("bookingStatus", "PENDING");
            request.setAttribute("paymentStatus", "UNPAID");
            request.getRequestDispatcher("/WEB-INF/views/user/bookingConfirm.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Home?error=invalid");
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Booking failed: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Home?error=booking_failed");
        }
    }
}
