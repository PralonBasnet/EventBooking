package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.BookingDAO;
import com.c11.EventBooking.dao.EventDAO;
import com.c11.EventBooking.dao.UserDAO;
import com.c11.EventBooking.model.EventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
  Serves the admin dashboard page.
 
 Sets four request attributes before forwarding:
   totalEvents    (int)              — KPI card
   totalBookings  (int)              — KPI card
   totalUsers     (int)              — KPI card (Bug 9)
   upcomingEvents (List<EventModel>) — upcoming events panel with venueName (Bug 10)
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final EventDAO   eventDAO   = new EventDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final UserDAO    userDAO    = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int totalEvents   = eventDAO.getTotalEvents();
            int totalBookings = bookingDAO.getTotalBookings();
            int totalUsers    = userDAO.getTotalUsers();
            List<EventModel> upcomingEvents = eventDAO.getAllEvents();

            request.setAttribute("totalEvents",    totalEvents);
            request.setAttribute("totalBookings",  totalBookings);
            request.setAttribute("totalUsers",     totalUsers);
            request.setAttribute("upcomingEvents", upcomingEvents);

        } catch (Exception e) {
            request.setAttribute("dashboardError",
                    "Could not load dashboard data: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/adminDashboard.jsp")
               .forward(request, response);
    }
}
