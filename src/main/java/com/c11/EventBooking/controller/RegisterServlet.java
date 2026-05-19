package com.c11.EventBooking.controller;

import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.service.RegisterService;
import com.c11.EventBooking.util.StringUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

// Handles user registration. 
@WebServlet("/Register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(RegisterServlet.class.getName());

    private final RegisterService registerService = new RegisterService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/public/signup.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName      = request.getParameter("fullName");
        String userName      = request.getParameter("userName");
        String contactNumber = request.getParameter("contactNumber");
        String dateOfBirth   = request.getParameter("dateOfBirth");
        String email         = request.getParameter("email");
        String password      = request.getParameter("password");

        UserModel user = new UserModel();
        user.setFullName(fullName);
        user.setUserName(userName);
        user.setContactNumber(contactNumber);
        user.setDateOfBirth(dateOfBirth);
        user.setEmail(email);
        user.setPassword(password);

        try {
            registerService.registerUser(user);
            response.sendRedirect(request.getContextPath() + "/Login?registered=true");

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMsg", e.getMessage());
            request.setAttribute("formFullName",      fullName);
            request.setAttribute("formUserName",      userName);
            request.setAttribute("formContactNumber", contactNumber);
            request.setAttribute("formDateOfBirth",   dateOfBirth);
            request.setAttribute("formEmail",         email);
            request.getRequestDispatcher("/WEB-INF/views/public/signup.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Registration failed with unexpected error", e);
            request.setAttribute("errorMsg", "Something went wrong. Please try again later.");
            request.setAttribute("formFullName",      fullName);
            request.setAttribute("formUserName",      userName);
            request.setAttribute("formContactNumber", contactNumber);
            request.setAttribute("formDateOfBirth",   dateOfBirth);
            request.setAttribute("formEmail",         email);
            request.getRequestDispatcher("/WEB-INF/views/public/signup.jsp")
                   .forward(request, response);
        }
    }
}
