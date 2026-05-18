package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.EventDAO;
import com.c11.EventBooking.dao.VenueDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Loads events for the browse page, with optional search filtering. */
@WebServlet("/Events")
public class EventsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(EventsServlet.class.getName());

    private final EventDAO eventDAO = new EventDAO();
    private final VenueDAO venueDAO = new VenueDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String q       = request.getParameter("q");
        String type    = request.getParameter("type");
        String venueID = request.getParameter("venueID");
        String from    = request.getParameter("from");
        String to      = request.getParameter("to");

        boolean hasFilter = (q != null && !q.isBlank())
                         || (type    != null && !type.isBlank())
                         || (venueID != null && !venueID.isBlank())
                         || (from    != null && !from.isBlank())
                         || (to      != null && !to.isBlank());

        try {
            if (hasFilter) {
                request.setAttribute("events", eventDAO.searchEvents(q, type, venueID, from, to));
            } else {
                request.setAttribute("events", eventDAO.getAllEvents());
            }
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Could not load events", e);
            request.setAttribute("eventsError", "Could not load events.");
        }

        try {
            request.setAttribute("venues", venueDAO.getAllVenues());
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Could not load venues for dropdown", e);
        }

        request.setAttribute("searchQ",       q);
        request.setAttribute("searchType",    type);
        request.setAttribute("searchVenueID", venueID);
        request.setAttribute("searchFrom",    from);
        request.setAttribute("searchTo",      to);

        request.getRequestDispatcher("/WEB-INF/views/user/events.jsp")
               .forward(request, response);
    }
}
