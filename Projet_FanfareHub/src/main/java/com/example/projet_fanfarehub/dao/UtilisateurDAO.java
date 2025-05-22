package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.model.Utilisateur;
import com.example.projet_fanfarehub.util.ConnexionBD;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class UtilisateurDAO {

    public void ajouter(Utilisateur utilisateur) {
        String sql = "INSERT INTO appuser (userid, email, passwordhash, firstname, lastname, gender, dietaryrestriction, creationdate, lastlogin, isadmin) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE, NULL, false)";

        try (Connection connexion = ConnexionBD.getConnexion();
             PreparedStatement stmt = connexion.prepareStatement(sql)) {

            String generatedId = UUID.randomUUID().toString();
            utilisateur.setId(generatedId);

            stmt.setString(1, generatedId);
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getMotDePasse()); // tu peux hasher plus tard
            stmt.setString(4, utilisateur.getPrenom());
            stmt.setString(5, utilisateur.getNom());
            stmt.setString(6, utilisateur.getGenre());
            stmt.setString(7, utilisateur.getAlimentaire());
            System.out.println("Tentative d'ajout : " + utilisateur.getEmail());
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Erreur SQL : " + e.getMessage());
            e.printStackTrace();
        }
    }

    public Utilisateur trouverParEmailEtMotDePasse(String email, String mdp) {
        String sql = "SELECT * FROM appuser WHERE email = ? AND passwordhash = ?";

        try (Connection connexion = ConnexionBD.getConnexion();
             PreparedStatement stmt = connexion.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, mdp);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Utilisateur(
                        rs.getString("userid"),
                        rs.getString("email"),
                        rs.getString("passwordhash"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("gender"),
                        rs.getString("dietaryrestriction"),
                        rs.getBoolean("isadmin")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Utilisateur> listerTous() {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String sql = "SELECT * FROM appuser";

        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                utilisateurs.add(new Utilisateur(
                        rs.getString("userid"),
                        rs.getString("email"),
                        rs.getString("passwordhash"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("gender"),
                        rs.getString("dietaryrestriction"),
                        rs.getBoolean("isadmin")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return utilisateurs;
    }

    public void supprimerParEmail(String email) {
        String sql = "DELETE FROM appuser WHERE email = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void toggleAdminParEmail(String email) {
        String sql = "UPDATE appuser SET isadmin = NOT isadmin WHERE email = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}