package com.c11.EventBooking.service;

import com.c11.EventBooking.dao.UserDAO;
import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.PasswordUtils;

import java.sql.SQLException;

/** Business logic for user registration. */
public class RegisterService {

    private final UserDAO userDAO = new UserDAO();

    public void registerUser(UserModel user)
            throws IllegalArgumentException, SQLException {

        // field-level validation

        if (isBlank(user.getFullName())) {
            throw new IllegalArgumentException("Full name is required.");
        }
        if (user.getFullName().matches(".*\\d.*")) {
            throw new IllegalArgumentException("Full name must not contain numbers.");
        }
        if (isBlank(user.getUserName())) {
            throw new IllegalArgumentException("Username is required.");
        }
        if (user.getUserName().contains(" ")) {
            throw new IllegalArgumentException("Username must not contain spaces.");
        }
        if (isBlank(user.getEmail())) {
            throw new IllegalArgumentException("Email is required.");
        }
        if (!user.getEmail().matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            throw new IllegalArgumentException("Invalid email format.");
        }
        if (isBlank(user.getContactNumber())) {
            throw new IllegalArgumentException("Contact number is required.");
        }
        if (!user.getContactNumber().matches("\\d+")) {
            throw new IllegalArgumentException("Contact number must contain digits only.");
        }
        if (isBlank(user.getDateOfBirth())) {
            throw new IllegalArgumentException("Date of birth is required.");
        }
        try {
            java.time.LocalDate dob = java.time.LocalDate.parse(user.getDateOfBirth());
            if (dob.isAfter(java.time.LocalDate.now())) {
                throw new IllegalArgumentException("Date of birth cannot be in the future.");
            }
        } catch (java.time.format.DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid date of birth format.");
        }
        if (isBlank(user.getPassword())) {
            throw new IllegalArgumentException("Password is required.");
        }
        if (user.getPassword().length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters.");
        }

        // uniqueness checks

        if (userDAO.usernameExists(user.getUserName())) {
            throw new IllegalArgumentException("Username is already taken.");
        }
        if (userDAO.emailExists(user.getEmail())) {
            throw new IllegalArgumentException("Email is already registered.");
        }

        // hash password before storing

        user.setPassword(PasswordUtils.getHashPassword(user.getPassword()));

        userDAO.registerUser(user);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
