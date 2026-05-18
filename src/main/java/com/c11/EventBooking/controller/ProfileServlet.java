package com.c11.EventBooking.controller;

import com.c11.EventBooking.dao.UserDAO;
import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.PasswordUtils;
import com.c11.EventBooking.util.SessionUtils;
import com.c11.EventBooking.util.StringUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/** Allows the logged-in user to view and update their profile. */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 5 * 1024 * 1024,
    maxRequestSize    = 10 * 1024 * 1024
)
@WebServlet("/Profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(ProfileServlet.class.getName());

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtils.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }
        request.setAttribute("avatarInitial", computeInitial(user));
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = SessionUtils.getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }

        String action = request.getParameter("action");
        if ("changePassword".equals(action)) {
            handlePasswordChange(request, response, user);
        } else {
            handleProfileUpdate(request, response, user);
        }
    }

    private void handlePasswordChange(HttpServletRequest req,
                                      HttpServletResponse res,
                                      UserModel user)
            throws ServletException, IOException {

        String current    = req.getParameter("currentPassword");
        String newPwd     = req.getParameter("newPassword");
        String confirmPwd = req.getParameter("confirmNewPassword");

        if (StringUtils.isBlank(current) || StringUtils.isBlank(newPwd) || StringUtils.isBlank(confirmPwd)) {
            req.setAttribute("pwdError", "All password fields are required.");
            forward(req, res, user);
            return;
        }
        if (!PasswordUtils.checkPassword(current, user.getPassword())) {
            req.setAttribute("pwdError", "Current password is incorrect.");
            forward(req, res, user);
            return;
        }
        if (!newPwd.equals(confirmPwd)) {
            req.setAttribute("pwdError", "New passwords do not match.");
            forward(req, res, user);
            return;
        }
        if (newPwd.length() < 6) {
            req.setAttribute("pwdError", "New password must be at least 6 characters.");
            forward(req, res, user);
            return;
        }

        try {
            String hashed = PasswordUtils.getHashPassword(newPwd);
            userDAO.updatePassword(user.getUserID(), hashed);
            user.setPassword(hashed);
            req.setAttribute("pwdSuccess", "Password changed successfully.");
        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to update password", e);
            req.setAttribute("pwdError", "Could not update password. Please try again.");
        }

        forward(req, res, user);
    }

    private void handleProfileUpdate(HttpServletRequest req,
                                     HttpServletResponse res,
                                     UserModel user)
            throws ServletException, IOException {

        String fullName      = req.getParameter("fullName");
        String userName      = req.getParameter("userName");
        String contactNumber = req.getParameter("contactNumber");
        String email         = req.getParameter("email");
        String dateOfBirth   = req.getParameter("dateOfBirth");

        if (StringUtils.isBlank(fullName) || StringUtils.isBlank(userName)
                || StringUtils.isBlank(contactNumber) || StringUtils.isBlank(email)) {
            req.setAttribute("profileError", "All fields are required.");
            forward(req, res, user);
            return;
        }
        if (fullName.matches(".*\\d.*")) {
            req.setAttribute("profileError", "Full name must not contain numbers.");
            forward(req, res, user);
            return;
        }
        if (!email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            req.setAttribute("profileError", "Invalid email format.");
            forward(req, res, user);
            return;
        }
        if (!contactNumber.matches("\\d+")) {
            req.setAttribute("profileError", "Contact number must contain digits only.");
            forward(req, res, user);
            return;
        }

        try {
            if (userDAO.usernameExistsForOther(userName, user.getUserID())) {
                req.setAttribute("profileError", "That username is already taken.");
                forward(req, res, user);
                return;
            }
            if (userDAO.emailExistsForOther(email, user.getUserID())) {
                req.setAttribute("profileError", "That email is already registered.");
                forward(req, res, user);
                return;
            }

            userDAO.updateUser(user.getUserID(), fullName, userName, contactNumber, email, dateOfBirth);
            user.setFullName(fullName);
            user.setUserName(userName);
            user.setContactNumber(contactNumber);
            user.setEmail(email);
            user.setDateOfBirth(dateOfBirth);

            Part filePart = req.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                String originalName = filePart.getSubmittedFileName();
                if (originalName != null && !originalName.trim().isEmpty()) {
                    String ext = "";
                    int dot = originalName.lastIndexOf('.');
                    if (dot >= 0) ext = originalName.substring(dot).toLowerCase();

                    String savedName = user.getUserID() + "_" + System.currentTimeMillis() + ext;
                    String uploadDir = req.getServletContext().getRealPath("/uploads/profiles");
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();

                    filePart.write(uploadDir + File.separator + savedName);
                    String relativePath = "uploads/profiles/" + savedName;
                    userDAO.updateProfilePicture(user.getUserID(), relativePath);
                    user.setProfilePicture(relativePath);
                }
            }

            req.setAttribute("profileSuccess", "Profile updated successfully.");

        } catch (Exception e) {
            LOG.log(Level.SEVERE, "Failed to update profile", e);
            req.setAttribute("profileError", "Update failed. Please try again.");
        }

        forward(req, res, user);
    }

    private void forward(HttpServletRequest req, HttpServletResponse res, UserModel user)
            throws ServletException, IOException {
        req.setAttribute("avatarInitial", computeInitial(user));
        req.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(req, res);
    }

    private String computeInitial(UserModel user) {
        String name = user.getFullName();
        if (name != null && !name.isEmpty()) return String.valueOf(name.charAt(0)).toUpperCase();
        name = user.getUserName();
        if (name != null && !name.isEmpty()) return String.valueOf(name.charAt(0)).toUpperCase();
        return "?";
    }
}
