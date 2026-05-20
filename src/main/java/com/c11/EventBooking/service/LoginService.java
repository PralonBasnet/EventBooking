package com.c11.EventBooking.service;

import com.c11.EventBooking.dao.UserDAO;
import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.PasswordUtils;

import java.sql.SQLException;

// Business logic for user authentication
public class LoginService {

    private final UserDAO userDAO = new UserDAO();

    public UserModel authenticate(String username, String password)
            throws SQLException, AccountPendingException, AccountSuspendedException {

        UserModel user = userDAO.loginUser(username);

        if (user == null) {
            return null; // username not found
        }

        if (!PasswordUtils.checkPassword(password, user.getPassword())) {
            return null; // wrong password — same return as unknown username to prevent enumeration
        }

        // Credentials correct — now enforce account status
        String status = user.getUserStatus();
        if ("PENDING".equalsIgnoreCase(status)) {
            throw new AccountPendingException("Account awaiting approval.");
        }
        if ("SUSPENDED".equalsIgnoreCase(status)) {
            throw new AccountSuspendedException("Account suspended.");
        }

        return user; // ACTIVE
    }
}
