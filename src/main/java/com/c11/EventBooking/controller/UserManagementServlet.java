package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/** Admin user management controller. */
@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("users", userDAO.getAllUsers());
        } catch (Exception e) {
            request.setAttribute("usersError", "Could not load users: " + e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/manageUsers.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action       = request.getParameter("action");
        String userIDStr    = request.getParameter("userID");
        String targetStatus = request.getParameter("targetStatus");

        if ("updateStatus".equals(action) && userIDStr != null) {
            // prevent status injection via tampered form values
            if (!"ACTIVE".equals(targetStatus) && !"SUSPENDED".equals(targetStatus)) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?error=update_failed");
                return;
            }
            try {
                int targetID = Integer.parseInt(userIDStr);
                userDAO.updateUserStatus(targetID, targetStatus);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?error=update_failed");
                return;
            }
        } else if ("updateRole".equals(action) && userIDStr != null) {
            String targetRole = request.getParameter("targetRole");
            // prevent role injection via tampered form values
            if (!"ADMIN".equals(targetRole) && !"USER".equals(targetRole)) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?error=update_failed");
                return;
            }
            try {
                int targetID = Integer.parseInt(userIDStr);
                userDAO.updateUserRole(targetID, targetRole);
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?error=update_failed");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
    }
}
