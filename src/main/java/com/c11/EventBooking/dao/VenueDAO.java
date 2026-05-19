package com.c11.EventBooking.dao;

import com.c11.EventBooking.model.VenueModel;
import com.c11.EventBooking.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// DAO for the {@code venue} table. 
public class VenueDAO {

    //helper

    private VenueModel mapRow(ResultSet rs) throws SQLException {
        VenueModel v = new VenueModel();
        v.setVenueID(rs.getInt("venueID"));
        v.setVenueName(rs.getString("venueName"));
        v.setVenueCapacity(rs.getInt("venueCapacity"));
        v.setVenueContact(rs.getString("venueContact"));
        v.setVenueAddress(rs.getString("venueAddress"));
        return v;
    }

    //CREATE 

    public int insertVenue(VenueModel venue) throws SQLException {
        String sql = "INSERT INTO venue "
                   + "(venueName, venueCapacity, venueContact, venueAddress) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, venue.getVenueName());
            pst.setInt(2, venue.getVenueCapacity());
            pst.setString(3, venue.getVenueContact());
            pst.setString(4, venue.getVenueAddress());
            return pst.executeUpdate();
        }
    }

    //READ

    public List<VenueModel> getAllVenues() throws SQLException {
        List<VenueModel> list = new ArrayList<>();
        String sql = "SELECT * FROM venue WHERE isDeleted = 0 ORDER BY venueName ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public VenueModel getVenueByID(int venueID) throws SQLException {
        String sql = "SELECT * FROM venue WHERE venueID = ? AND isDeleted = 0";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, venueID);
            try (ResultSet rs = pst.executeQuery()) {
                return rs.next() ? mapRow(rs) : null;
            }
        }
    }

    // UPDATE 

    public int updateVenue(VenueModel venue) throws SQLException {
        String sql = "UPDATE venue "
                   + "SET venueName=?, venueCapacity=?, venueContact=?, venueAddress=? "
                   + "WHERE venueID=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, venue.getVenueName());
            pst.setInt(2, venue.getVenueCapacity());
            pst.setString(3, venue.getVenueContact());
            pst.setString(4, venue.getVenueAddress());
            pst.setInt(5, venue.getVenueID());
            return pst.executeUpdate();
        }
    }

    //DELETE (soft)

    // soft-delete: isDeleted=1 avoids triggering the FK constraint on event.venueID
    public int deleteVenue(int venueID) throws SQLException {
        String sql = "UPDATE venue SET isDeleted = 1 WHERE venueID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, venueID);
            return pst.executeUpdate();
        }
    }
}
