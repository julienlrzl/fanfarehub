package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.model.Utilisateur;
import com.example.projet_fanfarehub.util.ConnexionBD;
import com.example.projet_fanfarehub.util.PasswordUtil;

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

            // Hachage du mot de passe AVANT insertion
            String hashedPassword = PasswordUtil.hash(utilisateur.getMotDePasse());
            stmt.setString(3, hashedPassword);

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

            // Hachage du mot de passe AVANT la recherche
            String hashed = PasswordUtil.hash(mdp);
            stmt.setString(2, hashed);

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
        String getIdSql = "SELECT userid FROM appuser WHERE email = ?";
        String deleteParticipation = "DELETE FROM participation WHERE userid = ?";
        String deleteBelongsToGroup = "DELETE FROM belongstogroup WHERE userid = ?";
        String deletePlaysInSection = "DELETE FROM playsinsection WHERE userid = ?";
        String deleteEvents = "DELETE FROM event WHERE userid = ?";
        String deleteUser = "DELETE FROM appuser WHERE email = ?";

        try (Connection conn = ConnexionBD.getConnexion()) {

            // Récupérer l'ID utilisateur à partir de l'email
            PreparedStatement getIdStmt = conn.prepareStatement(getIdSql);
            getIdStmt.setString(1, email);
            ResultSet rs = getIdStmt.executeQuery();

            if (!rs.next()) {
                System.out.println("Aucun utilisateur trouvé avec l'email : " + email);
                return;
            }

            String userId = rs.getString("userid");

            // Supprimer les dépendances dans l'ordre
            try (PreparedStatement ps1 = conn.prepareStatement(deleteParticipation);
                 PreparedStatement ps2 = conn.prepareStatement(deleteBelongsToGroup);
                 PreparedStatement ps3 = conn.prepareStatement(deletePlaysInSection);
                 PreparedStatement ps4 = conn.prepareStatement(deleteEvents);
                 PreparedStatement deleteUserStmt = conn.prepareStatement(deleteUser)) {

                ps1.setString(1, userId);
                ps1.executeUpdate();

                ps2.setString(1, userId);
                ps2.executeUpdate();

                ps3.setString(1, userId);
                ps3.executeUpdate();

                ps4.setString(1, userId);
                ps4.executeUpdate();

                deleteUserStmt.setString(1, email);
                deleteUserStmt.executeUpdate();

                System.out.println("Utilisateur et dépendances supprimés : " + email);
            }

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