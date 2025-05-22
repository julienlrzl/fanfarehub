package com.example.projet_fanfarehub.model;

import java.sql.Timestamp;

public class Event {
    private int id;
    private String nom;
    private Timestamp datetime;
    private int duree;
    private String lieu;
    private String description;
    private String userId;

    public Event(int id, String nom, Timestamp datetime, int duree, String lieu, String description, String userId) {
        this.id = id;
        this.nom = nom;
        this.datetime = datetime;
        this.duree = duree;
        this.lieu = lieu;
        this.description = description;
        this.userId = userId;
    }

    // Getters
    public int getId() { return id; }
    public String getNom() { return nom; }
    public Timestamp getDatetime() { return datetime; }
    public int getDuree() { return duree; }
    public String getLieu() { return lieu; }
    public String getDescription() { return description; }
    public String getUserId() { return userId; }

}