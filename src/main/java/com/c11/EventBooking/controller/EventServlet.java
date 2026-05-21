package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.EventDAO;
import com.c11.EventBooking.dao.VenueDAO;
import com.c11.EventBooking.model.EventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Admin CRUD controller for events. 
@WebServlet("/admin/events")
public class EventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final EventDAO  eventDAO  = new EventDAO();
    private final VenueDAO  venueDAO  = new VenueDAO();

    // ── doGet─//
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":  loadAddPage(request, response);  break;
                case "edit": loadEditPage(request, response); break;
                default:     loadEventsList(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/manageEvents.jsp")
                   .forward(request, response);
        }
    }

    // ── doPost ──//

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "add":    handleAdd(request, response);    break;
                case "update": handleUpdate(request, response); break;
                case "delete": handleDelete(request, response); break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/events");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/manageEvents.jsp")
                   .forward(request, response);
        }
    }

    // ── GET helpers ────//

    private void loadEventsList(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        req.setAttribute("events", eventDAO.getAllEvents());
        req.getRequestDispatcher("/WEB-INF/views/admin/manageEvents.jsp")
           .forward(req, res);
    }

    private void loadAddPage(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        req.setAttribute("venues", venueDAO.getAllVenues());
        req.getRequestDispatcher("/WEB-INF/views/admin/addEvent.jsp")
           .forward(req, res);
    }

    private void loadEditPage(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        EventModel event = eventDAO.getEventByID(id);
        if (event == null) {
            res.sendRedirect(req.getContextPath() + "/admin/events");
            return;
        }
        req.setAttribute("event", event);
        req.setAttribute("venues", venueDAO.getAllVenues());
        req.getRequestDispatcher("/WEB-INF/views/admin/editEvent.jsp")
           .forward(req, res);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        eventDAO.deleteEvent(id);
        res.sendRedirect(req.getContextPath() + "/admin/events?success=deleted");
    }

    // ── POST helpers ───//

    private void handleAdd(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String eventType     = req.getParameter("eventType");
        String eventPriceStr = req.getParameter("eventPrice");
        String eventDate     = req.getParameter("eventDate");
        String eventTime     = req.getParameter("eventTime");
        String venueIDStr    = req.getParameter("venueID");

        String error = validateEventForm(eventType, eventPriceStr, eventDate,
                                         eventTime, venueIDStr);
        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("venues", venueDAO.getAllVenues());
            req.getRequestDispatcher("/WEB-INF/views/admin/addEvent.jsp")
               .forward(req, res);
            return;
        }

        EventModel event = new EventModel();
        event.setEventType(eventType);
        event.setEventPrice(Double.parseDouble(eventPriceStr));
        event.setEventDate(eventDate);
        event.setEventTime(eventTime);
        event.setVenueID(Integer.parseInt(venueIDStr));

        eventDAO.insertEvent(event);
        res.sendRedirect(req.getContextPath() + "/admin/events?success=added");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String eventIDStr    = req.getParameter("eventID");
        String eventType     = req.getParameter("eventType");
        String eventPriceStr = req.getParameter("eventPrice");
        String eventDate     = req.getParameter("eventDate");
        String eventTime     = req.getParameter("eventTime");
        String venueIDStr    = req.getParameter("venueID");

        String error = validateEventForm(eventType, eventPriceStr, eventDate,
                                         eventTime, venueIDStr);
        if (error != null) {
            int id = Integer.parseInt(eventIDStr);
            req.setAttribute("error", error);
            req.setAttribute("event", eventDAO.getEventByID(id));
            req.setAttribute("venues", venueDAO.getAllVenues());
            req.getRequestDispatcher("/WEB-INF/views/admin/editEvent.jsp")
               .forward(req, res);
            return;
        }

        EventModel event = new EventModel();
        event.setEventID(Integer.parseInt(eventIDStr));
        event.setEventType(eventType);
        event.setEventPrice(Double.parseDouble(eventPriceStr));
        event.setEventDate(eventDate);
        event.setEventTime(eventTime);
        event.setVenueID(Integer.parseInt(venueIDStr));

        eventDAO.updateEvent(event);
        res.sendRedirect(req.getContextPath() + "/admin/events?success=updated");
    }

    // Returns an error message, or null if all fields are valid. 
    private String validateEventForm(String type, String priceStr,
                                     String date, String time, String venueIDStr) {
        if (isBlank(type))      return "Event type is required.";
        if (isBlank(date))      return "Event date is required.";
        if (isBlank(time))      return "Event time is required.";
        if (isBlank(venueIDStr)) return "Venue is required.";
        if (isBlank(priceStr))  return "Event price is required.";
        try {
            double price = Double.parseDouble(priceStr);
            if (price < 0) return "Price cannot be negative.";
        } catch (NumberFormatException e) {
            return "Event price must be a valid number.";
        }
        try {
            Integer.parseInt(venueIDStr);
        } catch (NumberFormatException e) {
            return "Invalid venue selection.";
        }
        return null;
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
