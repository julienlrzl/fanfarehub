package com.example.projet_fanfarehub.dao;

import com.example.projet_fanfarehub.util.ConnexionBD;

import java.sql.*;
import java.util.*;

public class GroupDAO {
    public List<String> getAllGroups() {
        return Arrays.asList(
                "commission_prestation",
                "commission_artistique",
                "commission_logistique",
                "commission_communication_interne"
        );
    }

    public List<String> getGroupsByEmail(String email) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT b.groupname FROM belongstogroup b JOIN appuser u ON u.userid = b.userid WHERE u.email = ?";
        try (Connection conn = ConnexionBD.getConnexion();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("groupname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void mettreAJourGroupes(String email, String[] groupes) {
        try (Connection conn = ConnexionBD.getConnexion()) {
            String userId = getUserIdByEmail(email, conn);
            PreparedStatement delete = conn.prepareStatement("DELETE FROM belongstogroup WHERE userid = ?");
            delete.setString(1, userId);
            delete.executeUpdate();

            if (groupes != null) {
                for (String name : groupes) {
                    PreparedStatement insert = conn.prepareStatement("INSERT INTO belongstogroup(userid, groupname) VALUES (?, ?)");
                    insert.setString(1, userId);
                    insert.setString(2, name);
                    insert.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
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