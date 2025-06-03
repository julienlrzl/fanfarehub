package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.util.ConnexionBD;

import java.sql.*;
import java.util.*;

public class ParticipationDAO {

    public void enregistrerParticipation(String email, int eventId, String instrument, String statut) {
        try (Connection conn = ConnexionBD.getConnexion()) {
            String userId = getUserIdByEmail(email, conn);
            if (userId == null) {
                System.out.println("Aucun utilisateur trouvé pour l'email : " + email);
                return;
            }

            // Supprimer ancienne participation
            PreparedStatement delete = conn.prepareStatement(
                    "DELETE FROM participation WHERE userid = ? AND eventid = ?");
            delete.setString(1, userId);
            delete.setInt(2, eventId);
            delete.executeUpdate();

            // Insérer la nouvelle participation
            PreparedStatement insert = conn.prepareStatement(
                    "INSERT INTO participation(userid, eventid, sectionname, status) VALUES (?, ?, ?, ?)");
            insert.setString(1, userId);
            insert.setInt(2, eventId);
            insert.setString(3, instrument);
            insert.setString(4, statut);
            insert.executeUpdate();

            System.out.println("Participation enregistrée : " + email + ", instrument=" + instrument + ", statut=" + statut);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String getUserIdByEmail(String email, Connection conn) {
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT userid FROM appuser WHERE email = ?")) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("userid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getInstrument(String email, int eventId) {
        String sql = "SELECT sectionname FROM participation p JOIN appuser u ON p.userid = u.userid WHERE u.email = ? AND eventid = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getString("sectionname");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getStatut(String email, int eventId) {
        String sql = "SELECT status FROM participation p JOIN appuser u ON p.userid = u.userid WHERE u.email = ? AND eventid = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getString("status");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }

    public Map<String, Map<String, List<String>>> getParticipantsParInstrumentEtStatut(int eventId) {
        Map<String, Map<String, List<String>>> result = new LinkedHashMap<>();

        String sql = """
            SELECT i.sectionname, p.status, u.firstname || ' ' || u.lastname AS nom
            FROM participation p
            JOIN appuser u ON p.userid = u.userid
            JOIN instrumentsection i ON i.sectionname = p.sectionname
            WHERE p.eventid = ?
            ORDER BY i.sectionname, p.status, nom
        """;

        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String section = rs.getString("sectionname");
                String statut = rs.getString("status");
                String nom = rs.getString("nom");

                result.putIfAbsent(section, new LinkedHashMap<>());
                result.get(section).putIfAbsent(statut, new ArrayList<>());
                result.get(section).get(statut).add(nom);
            }
            System.out.println("Participants pour eventid=" + eventId + " : " + result);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public void supprimerParticipation(String email, int eventId) {
        try (Connection conn = ConnexionBD.getConnexion()) {
            String userId = getUserIdByEmail(email, conn);
            if (userId == null) {
                System.out.println("Aucun utilisateur trouvé pour l'email : " + email);
                return;
            }

            PreparedStatement delete = conn.prepareStatement(
                    "DELETE FROM participation WHERE userid = ? AND eventid = ?");
            delete.setString(1, userId);
            delete.setInt(2, eventId);
            delete.executeUpdate();
            System.out.println("Participation supprimée pour " + email);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}