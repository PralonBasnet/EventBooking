package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.EventDAO;
import com.c11.EventBooking.model.EventModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Manages the session-based wishlist. */
@WebServlet("/Wishlist")
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(WishlistServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        LinkedHashSet<Integer> wishlist = ensureWishlist(request.getSession());
        List<EventModel> wishlistEvents = new ArrayList<>();
        if (!wishlist.isEmpty()) {
            EventDAO eventDAO = new EventDAO();
            for (int id : wishlist) {
                try {
                    EventModel ev = eventDAO.getEventByID(id);
                    if (ev != null) wishlistEvents.add(ev);
                } catch (Exception e) {
                    LOG.log(Level.SEVERE, "Failed to load wishlist event id=" + id, e);
                }
            }
        }
        request.setAttribute("wishlistEvents", wishlistEvents);
        request.getRequestDispatcher("/WEB-INF/views/user/wishlist.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        LinkedHashSet<Integer> wishlist = ensureWishlist(session);

        String action     = request.getParameter("action");
        String eventIDStr = request.getParameter("eventID");

        if ("clear".equals(action)) {
            wishlist.clear();
        } else if (eventIDStr != null) {
            try {
                int id = Integer.parseInt(eventIDStr);
                if ("add".equals(action))    wishlist.add(id);
                if ("remove".equals(action)) wishlist.remove(id);
            } catch (NumberFormatException ignored) {}
        }

        String ref = request.getHeader("Referer");
        if (ref != null && ref.contains("/Wishlist")) {
            response.sendRedirect(request.getContextPath() + "/Wishlist");
        } else {
            response.sendRedirect(request.getContextPath() + "/Home");
        }
    }

    @SuppressWarnings("unchecked")
    private LinkedHashSet<Integer> ensureWishlist(HttpSession session) {
        LinkedHashSet<Integer> wishlist =
            (LinkedHashSet<Integer>) session.getAttribute("wishlist");
        if (wishlist == null) {
            wishlist = new LinkedHashSet<>();
            session.setAttribute("wishlist", wishlist);
        }
        return wishlist;
    }
}
