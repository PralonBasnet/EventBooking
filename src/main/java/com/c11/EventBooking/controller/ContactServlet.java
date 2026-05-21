package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.ContactMessageDAO;
import com.c11.EventBooking.util.StringUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

//Handles the public contact form. 
@WebServlet("/Contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(ContactServlet.class.getName());

    private final ContactMessageDAO contactDAO = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/public/contact.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String message = request.getParameter("message");

        if (StringUtils.isBlank(name) || StringUtils.isBlank(email) || StringUtils.isBlank(message)) {
            request.setAttribute("errorMsg", "All fields are required.");
            request.setAttribute("formName",    name);
            request.setAttribute("formEmail",   email);
            request.setAttribute("formMessage", message);
            request.getRequestDispatcher("/WEB-INF/views/public/contact.jsp")
                   .forward(request, response);
            return;
        }

        try {
            contactDAO.insertMessage(name, email, message);
        } catch (Exception dbEx) {
            LOG.log(Level.SEVERE, "Failed to persist contact message", dbEx);
        }

        request.setAttribute("successMsg",
                "Thank you, " + name + "! Your message has been received. We'll get back to you within 24 hours.");
        request.getRequestDispatcher("/WEB-INF/views/public/contact.jsp")
               .forward(request, response);
    }
}
