package com.example.projet_fanfarehub.model;

public class Utilisateur {
    private String id;
    private String email;
    private String motDePasse;
    private String prenom;
    private String nom;
    private String genre;
    private String alimentaire;
    private boolean isAdmin;

    // Constructeur sans ID (ajout)
    public Utilisateur(String email, String motDePasse, String prenom, String nom, String genre, String alimentaire) {
        this.email = email;
        this.motDePasse = motDePasse;
        this.prenom = prenom;
        this.nom = nom;
        this.genre = genre;
        this.alimentaire = alimentaire;
    }

    // Constructeur complet
    public Utilisateur(String id, String email, String motDePasse, String prenom, String nom, String genre, String alimentaire, boolean isAdmin) {
        this(email, motDePasse, prenom, nom, genre, alimentaire);
        this.id = id;
        this.isAdmin = isAdmin;
    }

    // Getters & Setters
    public String getId() { return id; }
    public String getEmail() { return email; }
    public String getMotDePasse() { return motDePasse; }
    public String getPrenom() { return prenom; }
    public String getNom() { return nom; }
    public String getGenre() { return genre; }
    public String getAlimentaire() { return alimentaire; }

    public void setId(String id) { this.id = id; }
    public void setEmail(String email) { this.email = email; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public void setNom(String nom) { this.nom = nom; }
    public void setGenre(String genre) { this.genre = genre; }
    public void setAlimentaire(String alimentaire) { this.alimentaire = alimentaire; }

    public boolean isAdmin() {
        return isAdmin;
    }
    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
}