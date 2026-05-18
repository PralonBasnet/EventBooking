package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.logging.*;

// Handles admin view and management of contact messages. 
@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(AdminMessagesServlet.class.getName());
    private final ContactMessageDAO dao = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            req.setAttribute("messages", dao.getAllMessages());
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Could not load messages", e);
            req.setAttribute("messagesError", "Could not load messages.");
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/manageMessages.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action    = req.getParameter("action");
        String idStr     = req.getParameter("messageID");
        try {
            int id = Integer.parseInt(idStr);
            if ("resolve".equals(action))  dao.updateStatus(id, "RESOLVED");
            if ("reopen".equals(action))   dao.updateStatus(id, "OPEN");
            res.sendRedirect(req.getContextPath() + "/admin/messages?success=" + action);
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Could not update message status", e);
            res.sendRedirect(req.getContextPath() + "/admin/messages?error=update_failed");
        }
    }
}
