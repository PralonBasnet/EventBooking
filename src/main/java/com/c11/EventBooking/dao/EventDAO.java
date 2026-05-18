package com.c11.EventBooking.dao;

import com.c11.EventBooking.model.EventModel;
import com.c11.EventBooking.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** DAO for the {@code event} table. */
public class EventDAO {

    // ── helper ───────────────────────────────────────────────────────────────

    private EventModel mapRow(ResultSet rs) throws SQLException {
        EventModel e = new EventModel();
        e.setEventID(rs.getInt("eventID"));
        e.setVenueID(rs.getInt("venueID"));
        e.setEventType(rs.getString("eventType"));
        e.setEventPrice(rs.getDouble("eventPrice"));
        e.setEventDate(rs.getString("eventDate"));
        e.setEventTime(rs.getString("eventTime"));
        e.setVenueName(rs.getString("venueName"));
        return e;
    }

    // ── CREATE ───────────────────────────────────────────────────────────────

    public int insertEvent(EventModel event) throws SQLException {
        String sql = "INSERT INTO event "
                   + "(venueID, eventType, eventPrice, eventDate, eventTime) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, event.getVenueID());
            pst.setString(2, event.getEventType());
            pst.setDouble(3, event.getEventPrice());
            pst.setString(4, event.getEventDate());
            pst.setString(5, event.getEventTime());
            return pst.executeUpdate();
        }
    }

    // ── READ ─────────────────────────────────────────────────────────────────

    public List<EventModel> getAllEvents() throws SQLException {
        List<EventModel> list = new ArrayList<>();
        String sql = "SELECT e.*, v.venueName "
                   + "FROM event e "
                   + "JOIN venue v ON e.venueID = v.venueID "
                   + "WHERE e.isDeleted = 0 "
                   + "ORDER BY e.eventDate ASC, e.eventTime ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public EventModel getEventByID(int eventID) throws SQLException {
        String sql = "SELECT e.*, v.venueName "
                   + "FROM event e "
                   + "JOIN venue v ON e.venueID = v.venueID "
                   + "WHERE e.eventID = ? AND e.isDeleted = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, eventID);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    public int getTotalEvents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM event WHERE isDeleted = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    public List<EventModel> searchEvents(String q, String type, String venueID,
                                         String from, String to) throws SQLException {
        List<EventModel> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT e.*, v.venueName FROM event e "
          + "JOIN venue v ON e.venueID = v.venueID "
          + "WHERE e.isDeleted = 0 ");

        if (q != null && !q.trim().isEmpty()) {
            sql.append("AND (e.eventType LIKE ? OR v.venueName LIKE ?) ");
        }
        if (type != null && !type.trim().isEmpty()) {
            sql.append("AND e.eventType = ? ");
        }
        if (venueID != null && !venueID.trim().isEmpty()) {
            sql.append("AND e.venueID = ? ");
        }
        if (from != null && !from.trim().isEmpty()) {
            sql.append("AND e.eventDate >= ? ");
        }
        if (to != null && !to.trim().isEmpty()) {
            sql.append("AND e.eventDate <= ? ");
        }
        sql.append("ORDER BY e.eventDate ASC, e.eventTime ASC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (q != null && !q.trim().isEmpty()) {
                String like = "%" + q.trim() + "%";
                pst.setString(idx++, like);
                pst.setString(idx++, like);
            }
            if (type != null && !type.trim().isEmpty()) {
                pst.setString(idx++, type.trim());
            }
            if (venueID != null && !venueID.trim().isEmpty()) {
                pst.setInt(idx++, Integer.parseInt(venueID.trim()));
            }
            if (from != null && !from.trim().isEmpty()) {
                pst.setString(idx++, from.trim());
            }
            if (to != null && !to.trim().isEmpty()) {
                pst.setString(idx++, to.trim());
            }

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ── UPDATE ───────────────────────────────────────────────────────────────

    public int updateEvent(EventModel event) throws SQLException {
        String sql = "UPDATE event "
                   + "SET venueID=?, eventType=?, eventPrice=?, "
                   + "    eventDate=?, eventTime=? "
                   + "WHERE eventID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, event.getVenueID());
            pst.setString(2, event.getEventType());
            pst.setDouble(3, event.getEventPrice());
            pst.setString(4, event.getEventDate());
            pst.setString(5, event.getEventTime());
            pst.setInt(6, event.getEventID());
            return pst.executeUpdate();
        }
    }

    // ── DELETE (soft) ─────────────────────────────────────────────────────────

    // soft-delete preserves linked bookings for audit purposes
    public int deleteEvent(int eventID) throws SQLException {
        String sql = "UPDATE event SET isDeleted = 1 WHERE eventID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, eventID);
            return pst.executeUpdate();
        }
    }
}
