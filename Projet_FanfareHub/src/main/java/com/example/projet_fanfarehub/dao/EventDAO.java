package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.model.Event;
import com.example.projet_fanfarehub.util.ConnexionBD;

import java.sql.*;
import java.util.*;

public class EventDAO {
    public Event getById(int id) {
        String sql = "SELECT * FROM event WHERE eventid = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Event(
                        rs.getInt("eventid"),
                        rs.getString("eventname"),
                        rs.getTimestamp("datetime"),
                        rs.getInt("duration"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("userid")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Event> getTousLesEvenements() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM event ORDER BY datetime DESC";

        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Event(
                        rs.getInt("eventid"),
                        rs.getString("eventname"),
                        rs.getTimestamp("datetime"),
                        rs.getInt("duration"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("userid")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void ajouter(Event e) {
        String sql = "INSERT INTO event(eventname, datetime, duration, location, description, userid) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getNom());
            stmt.setTimestamp(2, e.getDatetime());
            stmt.setInt(3, e.getDuree());
            stmt.setString(4, e.getLieu());
            stmt.setString(5, e.getDescription());
            stmt.setString(6, e.getUserId());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void modifier(Event e) {
        String sql = "UPDATE event SET eventname=?, datetime=?, duration=?, location=?, description=? WHERE eventid=? AND userid=?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, e.getNom());
            stmt.setTimestamp(2, e.getDatetime());
            stmt.setInt(3, e.getDuree());
            stmt.setString(4, e.getLieu());
            stmt.setString(5, e.getDescription());
            stmt.setInt(6, e.getId());
            stmt.setString(7, e.getUserId());
            stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void supprimer(int id, String userId) {
        String sql = "DELETE FROM event WHERE eventid = ? AND userid = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setString(2, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}