package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.util.ConnexionBD;

import java.sql.*;
import java.util.*;

public class InstrumentSectionDAO {

    public List<String> getAllSections() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT sectionname FROM instrumentsection ORDER BY sectionname";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getString("sectionname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getSectionsByEmail(String email) {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT p.sectionname
            FROM playsinsection p
            JOIN appuser u ON u.userid = p.userid
            WHERE u.email = ?
        """;

        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("sectionname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void mettreAJourPupitres(String email, String[] sections) {
        try (Connection conn = ConnexionBD.getConnexion()) {
            String userId = getUserIdByEmail(email, conn);
            if (userId == null) return;

            PreparedStatement delete = conn.prepareStatement("DELETE FROM playsinsection WHERE userid = ?");
            delete.setString(1, userId);
            delete.executeUpdate();

            if (sections != null) {
                for (String name : sections) {
                    PreparedStatement insert = conn.prepareStatement(
                            "INSERT INTO playsinsection(userid, sectionname) VALUES (?, ?)");
                    insert.setString(1, userId);
                    insert.setString(2, name);
                    insert.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void ajouterPupitre(String nom) {
        String sql = "INSERT INTO instrumentsection(sectionname) VALUES (?)";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nom);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de l'ajout du pupitre (déjà existant ?) : " + e.getMessage());
        }
    }

    public void supprimerPupitre(String nom) {
        String sql = "DELETE FROM instrumentsection WHERE sectionname = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nom);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression du pupitre : " + e.getMessage());
        }
    }

    private String getUserIdByEmail(String email, Connection conn) throws SQLException {
        PreparedStatement stmt = conn.prepareStatement("SELECT userid FROM appuser WHERE email = ?");
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getString("userid");
        return null;
    }
}