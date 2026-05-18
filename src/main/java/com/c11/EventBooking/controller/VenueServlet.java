package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.VenueDAO;
import com.c11.EventBooking.model.VenueModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Admin CRUD controller for venues. */
@WebServlet("/admin/venues")
public class VenueServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final VenueDAO venueDAO = new VenueDAO();

    // ── doGet ─────────────────────────────────────────────────────────────────

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
                default:     loadVenuesList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            try {
                request.setAttribute("venues", venueDAO.getAllVenues());
            } catch (Exception e2) {
                e2.printStackTrace();
                request.setAttribute("venuesError", "Could not load venues list.");
            }
            request.getRequestDispatcher("/WEB-INF/views/admin/manageVenues.jsp")
                   .forward(request, response);
        }
    }

    // ── doPost ────────────────────────────────────────────────────────────────

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
                    response.sendRedirect(request.getContextPath() + "/admin/venues");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/manageVenues.jsp")
                   .forward(request, response);
        }
    }

    // ── GET helpers ───────────────────────────────────────────────────────────

    private void loadVenuesList(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        req.setAttribute("venues", venueDAO.getAllVenues());
        req.getRequestDispatcher("/WEB-INF/views/admin/manageVenues.jsp")
           .forward(req, res);
    }

    private void loadAddPage(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        req.getRequestDispatcher("/WEB-INF/views/admin/addVenue.jsp")
           .forward(req, res);
    }

    private void loadEditPage(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        VenueModel venue = venueDAO.getVenueByID(id);
        if (venue == null) {
            res.sendRedirect(req.getContextPath() + "/admin/venues");
            return;
        }
        req.setAttribute("venue", venue);
        req.getRequestDispatcher("/WEB-INF/views/admin/editVenue.jsp")
           .forward(req, res);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse res)
            throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        // soft-delete: marks isDeleted=1, never fires the event→venue FK constraint
        venueDAO.deleteVenue(id);
        res.sendRedirect(req.getContextPath() + "/admin/venues?success=deleted");
    }

    // ── POST helpers ──────────────────────────────────────────────────────────

    private void handleAdd(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String venueName    = req.getParameter("venueName");
        String capacityStr  = req.getParameter("venueCapacity");
        String venueContact = req.getParameter("venueContact");
        String venueAddress = req.getParameter("venueAddress");

        String error = validateVenueForm(venueName, capacityStr, venueContact, venueAddress);
        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("/WEB-INF/views/admin/addVenue.jsp")
               .forward(req, res);
            return;
        }

        VenueModel venue = new VenueModel();
        venue.setVenueName(venueName.trim());
        venue.setVenueCapacity(Integer.parseInt(capacityStr));
        venue.setVenueContact(venueContact.trim());
        venue.setVenueAddress(venueAddress.trim());

        venueDAO.insertVenue(venue);
        res.sendRedirect(req.getContextPath() + "/admin/venues?success=added");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse res)
            throws Exception {

        String venueIDStr   = req.getParameter("venueID");
        String venueName    = req.getParameter("venueName");
        String capacityStr  = req.getParameter("venueCapacity");
        String venueContact = req.getParameter("venueContact");
        String venueAddress = req.getParameter("venueAddress");

        String error = validateVenueForm(venueName, capacityStr, venueContact, venueAddress);
        if (error != null) {
            int id = Integer.parseInt(venueIDStr);
            req.setAttribute("error", error);
            req.setAttribute("venue", venueDAO.getVenueByID(id));
            req.getRequestDispatcher("/WEB-INF/views/admin/editVenue.jsp")
               .forward(req, res);
            return;
        }

        VenueModel venue = new VenueModel();
        venue.setVenueID(Integer.parseInt(venueIDStr));
        venue.setVenueName(venueName.trim());
        venue.setVenueCapacity(Integer.parseInt(capacityStr));
        venue.setVenueContact(venueContact.trim());
        venue.setVenueAddress(venueAddress.trim());

        venueDAO.updateVenue(venue);
        res.sendRedirect(req.getContextPath() + "/admin/venues?success=updated");
    }

    private String validateVenueForm(String name, String capacityStr,
                                     String contact, String address) {
        if (isBlank(name))        return "Venue name is required.";
        if (isBlank(contact))     return "Contact number is required.";
        if (isBlank(address))     return "Address is required.";
        if (isBlank(capacityStr)) return "Capacity is required.";
        try {
            int cap = Integer.parseInt(capacityStr);
            if (cap < 1) return "Capacity must be at least 1.";
        } catch (NumberFormatException e) {
            return "Capacity must be a valid whole number.";
        }
        return null;
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
