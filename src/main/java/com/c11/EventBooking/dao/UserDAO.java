package com.c11.EventBooking.dao;

import com.c11.EventBooking.model.UserModel;
import com.c11.EventBooking.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class UserDAO {

   

    private UserModel mapRow(ResultSet rs) throws SQLException {
        UserModel u = new UserModel();
        u.setUserID(rs.getInt("userID"));
        u.setFullName(rs.getString("fullName"));
        u.setUserName(rs.getString("userName"));
        u.setContactNumber(rs.getString("contactNumber"));
        u.setEmail(rs.getString("email"));
        u.setUserStatus(rs.getString("userStatus"));
        u.setUserRole(rs.getString("userRole"));
        u.setPassword(rs.getString("password"));
        u.setProfilePicture(rs.getString("profilePicture"));
        u.setDateOfBirth(rs.getString("dateOfBirth"));
        return u;
    }



    // inserts with PENDING status and USER role; admin activates the account before first login
    public int registerUser(UserModel user) throws SQLException {
        String sql = "INSERT INTO `user` "
                   + "(fullName, userName, contactNumber, dateOfBirth, email, userStatus, userRole, password) "
                   + "VALUES (?, ?, ?, ?, ?, 'PENDING', 'USER', ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, user.getFullName());
            pst.setString(2, user.getUserName());
            pst.setString(3, user.getContactNumber());
            pst.setString(4, user.getDateOfBirth());
            pst.setString(5, user.getEmail());
            pst.setString(6, user.getPassword());
            return pst.executeUpdate();
        }
    }

    // Read

    public UserModel loginUser(String username) throws SQLException {
        String sql = "SELECT * FROM `user` WHERE userName = ? AND isDeleted = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, username);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    public UserModel getUserByID(int userID) throws SQLException {
        String sql = "SELECT * FROM `user` WHERE userID = ? AND isDeleted = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, userID);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT * FROM `user` WHERE isDeleted = 0 ORDER BY userID ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM `user` WHERE isDeleted = 0 AND userRole = 'USER'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // Duplicate Checks

    // includes soft-deleted accounts to prevent username reuse
    public boolean usernameExists(String username) throws SQLException {
        String sql = "SELECT userID FROM `user` WHERE userName = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, username);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        }
    }

    // includes soft-deleted accounts to prevent email reuse
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT userID FROM `user` WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        }
    }

   // Update

    public int updateUser(int userID, String fullName, String userName,
                          String contactNumber, String email, String dateOfBirth) throws SQLException {

        String sql = "UPDATE `user` "
                   + "SET fullName=?, userName=?, contactNumber=?, email=?, dateOfBirth=? "
                   + "WHERE userID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, fullName);
            pst.setString(2, userName);
            pst.setString(3, contactNumber);
            pst.setString(4, email);
            pst.setString(5, dateOfBirth);
            pst.setInt(6, userID);
            return pst.executeUpdate();
        }
    }

    // separate from updateUser() so text-field saves never clear an existing picture
    public int updateProfilePicture(int userID, String relativePath) throws SQLException {
        String sql = "UPDATE `user` SET profilePicture = ? WHERE userID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, relativePath);
            pst.setInt(2, userID);
            return pst.executeUpdate();
        }
    }

    public int updateUserStatus(int userID, String status) throws SQLException {
        String sql = "UPDATE `user` SET userStatus = ? WHERE userID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, status);
            pst.setInt(2, userID);
            return pst.executeUpdate();
        }
    }

    public int updateUserRole(int userID, String role) throws SQLException {
        String sql = "UPDATE `user` SET userRole = ? WHERE userID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, role);
            pst.setInt(2, userID);
            return pst.executeUpdate();
        }
    }

    // renames username/email to free the UNIQUE constraint for future accounts
    public int softDeleteUser(int userID) throws SQLException {
        String sql = "UPDATE `user` SET isDeleted=1, "
                   + "userName=CONCAT(userName,'_del_',userID), "
                   + "email=CONCAT(email,'_del_',userID) "
                   + "WHERE userID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, userID);
            return pst.executeUpdate();
        }
    }

    public int updatePassword(int userID, String hashedPassword) throws SQLException {
        String sql = "UPDATE `user` SET password=? WHERE userID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, hashedPassword);
            pst.setInt(2, userID);
            return pst.executeUpdate();
        }
    }

    // True if the username is taken by any user OTHER than excludeUserID.
    public boolean usernameExistsForOther(String username, int excludeUserID) throws SQLException {
        String sql = "SELECT userID FROM `user` WHERE userName=? AND userID<>?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, username);
            pst.setInt(2, excludeUserID);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        }
    }

    // True if the email is taken by any user OTHER than excludeUserID.
    public boolean emailExistsForOther(String email, int excludeUserID) throws SQLException {
        String sql = "SELECT userID FROM `user` WHERE email=? AND userID<>?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);
            pst.setInt(2, excludeUserID);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        }
    }
}
