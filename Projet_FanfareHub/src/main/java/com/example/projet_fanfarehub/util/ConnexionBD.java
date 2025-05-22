package com.example.projet_fanfarehub.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnexionBD {

    private static final String URL = "jdbc:postgresql://localhost:5432/fanfarehub";
    private static final String UTILISATEUR = "tp_user";
    private static final String MOT_DE_PASSE = "Habere13";

    public static Connection getConnexion() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver PostgreSQL non trouvé", e);
        }
        return DriverManager.getConnection(URL, UTILISATEUR, MOT_DE_PASSE);
    }
}