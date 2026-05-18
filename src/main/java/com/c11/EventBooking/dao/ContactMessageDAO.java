package com.c11.EventBooking.dao;

import com.c11.EventBooking.util.DBConnection;
import java.sql.*;
import java.util.*;

/** DAO for the {@code contact_message} table. */
public class ContactMessageDAO {

    public int insertMessage(String name, String email, String message) throws SQLException {
        String sql = "INSERT INTO contact_message (name, email, message) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, message);
            return pst.executeUpdate();
        }
    }

    public List<Map<String, String>> getAllMessages() throws SQLException {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT messageID, name, email, message, status, createdAt " +
                     "FROM contact_message ORDER BY createdAt DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                Map<String, String> row = new LinkedHashMap<>();
                row.put("messageID", String.valueOf(rs.getInt("messageID")));
                row.put("name",      rs.getString("name"));
                row.put("email",     rs.getString("email"));
                row.put("message",   rs.getString("message"));
                row.put("status",    rs.getString("status"));
                row.put("createdAt", rs.getString("createdAt"));
                list.add(row);
            }
        }
        return list;
    }

    public int updateStatus(int messageID, String status) throws SQLException {
        String sql = "UPDATE contact_message SET status=? WHERE messageID=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, status);
            pst.setInt(2, messageID);
            return pst.executeUpdate();
        }
    }
}
