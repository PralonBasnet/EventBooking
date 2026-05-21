package com.c11.EventBooking.dao;

import com.c11.EventBooking.model.Booking;
import com.c11.EventBooking.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** DAO for the {@code booking} table. */
public class BookingDAO {

    // maps the SELECT result from a JOIN query into a Booking object
    private Booking mapJoinRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingID(rs.getInt("bookingID"));
        b.setUserID(rs.getInt("userID"));
        b.setEventID(rs.getInt("eventID"));
        b.setBookingStatus(rs.getString("bookingStatus"));
        b.setBookingDate(rs.getString("bookingDate"));
        b.setTotalAmount(rs.getDouble("totalAmount"));
        b.setPaymentStatus(rs.getString("paymentStatus"));
        b.setEventType(rs.getString("eventType"));
        b.setEventDate(rs.getString("eventDate"));
        b.setEventTime(rs.getString("eventTime"));
        b.setVenueName(rs.getString("venueName"));
        // customerName is only present in getAllBookings (admin JOIN); ignore if absent
        try { b.setCustomerName(rs.getString("customerName")); } catch (SQLException ignored) {}
        return b;
    }

    // maps a plain booking row (no JOIN columns)
    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingID(rs.getInt("bookingID"));
        b.setUserID(rs.getInt("userID"));
        b.setEventID(rs.getInt("eventID"));
        b.setBookingStatus(rs.getString("bookingStatus"));
        b.setBookingDate(rs.getString("bookingDate"));
        b.setTotalAmount(rs.getDouble("totalAmount"));
        b.setPaymentStatus(rs.getString("paymentStatus"));
        return b;
    }

    // CREATE

    // returns the generated bookingID so BookingServlet can pass it to the confirmation page
    public int insertBooking(Booking booking) throws SQLException {
        String sql = "INSERT INTO booking "
                   + "(userID, eventID, bookingStatus, bookingDate, totalAmount, paymentStatus) "
                   + "VALUES (?, ?, 'PENDING', NOW(), ?, 'UNPAID')";

        Connection con = DBConnection.getConnection();
        con.setAutoCommit(false);
        try (PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, booking.getUserID());
            pst.setInt(2, booking.getEventID());
            pst.setDouble(3, booking.getTotalAmount());
            pst.executeUpdate();

            int generatedID = -1;
            try (ResultSet keys = pst.getGeneratedKeys()) {
                if (keys.next()) generatedID = keys.getInt(1);
            }

            con.commit();
            return generatedID;
        } catch (SQLException e) {
            con.rollback();
            throw e;
        } finally {
            con.setAutoCommit(true);
            con.close();
        }
    }

    // ── READ ─────────────────────────────────────────────────────────────────

    public List<Booking> getBookingsByUser(int userID) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, e.eventType, e.eventDate, e.eventTime, v.venueName "
                   + "FROM booking b "
                   + "JOIN event e  ON b.eventID  = e.eventID "
                   + "JOIN venue v  ON e.venueID   = v.venueID "
                   + "WHERE b.userID = ? AND b.isDeleted = 0 "
                   + "ORDER BY b.bookingDate DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, userID);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) list.add(mapJoinRow(rs));
            }
        }
        return list;
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, e.eventType, e.eventDate, e.eventTime, v.venueName, "
                   + "u.fullName AS customerName "
                   + "FROM booking b "
                   + "JOIN event e ON b.eventID = e.eventID "
                   + "JOIN venue v ON e.venueID = v.venueID "
                   + "JOIN `user` u ON b.userID = u.userID "
                   + "WHERE b.isDeleted = 0 "
                   + "ORDER BY b.bookingDate DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) list.add(mapJoinRow(rs));
        }
        return list;
    }

    public List<Booking> getBookingsByEvent(int eventID) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM booking WHERE eventID=? AND isDeleted=0 ORDER BY bookingDate DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, eventID);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public int getTotalBookings() throws SQLException {
        String sql = "SELECT COUNT(*) FROM booking WHERE isDeleted=0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ── UPDATE ───────────────────────────────────────────────────────────────

    public int updateBookingStatus(int bookingID, String status) throws SQLException {
        String sql = "UPDATE booking SET bookingStatus=? WHERE bookingID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, status);
            pst.setInt(2, bookingID);
            return pst.executeUpdate();
        }
    }

    public int updatePaymentStatus(int bookingID, String status) throws SQLException {
        String sql = "UPDATE booking SET paymentStatus=? WHERE bookingID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, status);
            pst.setInt(2, bookingID);
            return pst.executeUpdate();
        }
    }

    // ── REPORTS ──────────────────────────────────────────────────────────────

    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT COALESCE(SUM(totalAmount),0) FROM booking "
                   + "WHERE isDeleted=0 AND bookingStatus='CONFIRMED' AND paymentStatus='PAID'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }

    public Map<String, Integer> getBookingsByStatus() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT bookingStatus, COUNT(*) AS cnt FROM booking "
                   + "WHERE isDeleted=0 GROUP BY bookingStatus ORDER BY bookingStatus";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) result.put(rs.getString("bookingStatus"), rs.getInt("cnt"));
        }
        return result;
    }

    public Map<String, Integer> getBookingsPerMonth() throws SQLException {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT DATE_FORMAT(bookingDate,'%Y-%m') AS mo, COUNT(*) AS cnt "
                   + "FROM booking WHERE isDeleted=0 "
                   + "GROUP BY mo ORDER BY mo DESC LIMIT 12";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) result.put(rs.getString("mo"), rs.getInt("cnt"));
        }
        return result;
    }

    public List<String[]> getMostBookedEvents() throws SQLException {
        List<String[]> result = new ArrayList<>();
        String sql = "SELECT e.eventType, v.venueName, COUNT(*) AS cnt "
                   + "FROM booking b "
                   + "JOIN event e ON b.eventID = e.eventID "
                   + "JOIN venue v ON e.venueID = v.venueID "
                   + "WHERE b.isDeleted=0 "
                   + "GROUP BY b.eventID ORDER BY cnt DESC LIMIT 5";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                String label = rs.getString("eventType") + " @ " + rs.getString("venueName");
                result.add(new String[]{ label, String.valueOf(rs.getInt("cnt")) });
            }
        }
        return result;
    }

    // cancels and marks refunded atomically; rolls back both UPDATEs if either fails
    public void cancelAndRefund(int bookingID) throws SQLException {
        String sql1 = "UPDATE booking SET bookingStatus='CANCELLED' WHERE bookingID=?";
        String sql2 = "UPDATE booking SET paymentStatus='REFUNDED'  WHERE bookingID=?";

        Connection con = DBConnection.getConnection();
        con.setAutoCommit(false);
        try (PreparedStatement p1 = con.prepareStatement(sql1);
             PreparedStatement p2 = con.prepareStatement(sql2)) {

            p1.setInt(1, bookingID);
            p1.executeUpdate();

            p2.setInt(1, bookingID);
            p2.executeUpdate();

            con.commit();
        } catch (SQLException e) {
            con.rollback();
            throw e;
        } finally {
            con.setAutoCommit(true);
            con.close();
        }
    }

    // each String[] = {eventType, venueName, bookingCount, venueCapacity, loadPercent}
    public List<String[]> getEventLoadStats() throws SQLException {
        List<String[]> result = new ArrayList<>();
        String sql =
            "SELECT e.eventType, v.venueName, v.venueCapacity, COUNT(b.bookingID) AS bookingCount " +
            "FROM event e " +
            "JOIN venue v ON e.venueID = v.venueID " +
            "LEFT JOIN booking b ON b.eventID = e.eventID AND b.isDeleted=0 " +
            "WHERE e.isDeleted=0 " +
            "GROUP BY e.eventID " +
            "ORDER BY bookingCount DESC LIMIT 5";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                int cap   = rs.getInt("venueCapacity");
                int cnt   = rs.getInt("bookingCount");
                int pct   = cap > 0 ? Math.min(100, cnt * 100 / cap) : 0;
                result.add(new String[]{
                    rs.getString("eventType"),
                    rs.getString("venueName"),
                    String.valueOf(cnt),
                    String.valueOf(cap),
                    String.valueOf(pct)
                });
            }
        }
        return result;
    }

    public String getMostPopularType() throws SQLException {
        String sql = "SELECT e.eventType, COUNT(*) AS cnt "
                   + "FROM booking b "
                   + "JOIN event e ON b.eventID = e.eventID "
                   + "WHERE b.isDeleted=0 "
                   + "GROUP BY e.eventType ORDER BY cnt DESC LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) return rs.getString("eventType");
        }
        return "N/A";
    }
}
