-- Table User
CREATE TABLE "user" (
    id_fanfaron SERIAL PRIMARY KEY,
    nom_utilisateur VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mot_de_passe TEXT NOT NULL,
    prenom VARCHAR(50),
    nom VARCHAR(50),
    genre VARCHAR(10) CHECK (genre IN ('Homme', 'Femme', 'Autre')),
    contrainte_alimentaire VARCHAR(20) CHECK (contrainte_alimentaire IN ('Aucune', 'Végétarien', 'Vegan', 'Sans Porc')),
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    derniere_connexion TIMESTAMP
);

-- Table Evenement
CREATE TABLE evenement (
    id_evenement SERIAL PRIMARY KEY,
    nom_evenement VARCHAR(100) NOT NULL,
    date_evenement TIMESTAMP NOT NULL,
    lieu VARCHAR(200),
    description TEXT
);

-- Table Groupe (Participation entre Users et Événements)
CREATE TABLE groupe (
    id_fanfaron INT NOT NULL,
    id_evenement INT NOT NULL,
    role VARCHAR(50),
    PRIMARY KEY (id_fanfaron, id_evenement),
    FOREIGN KEY (id_fanfaron) REFERENCES "user"(id_fanfaron) ON DELETE CASCADE,
    FOREIGN KEY (id_evenement) REFERENCES evenement(id_evenement) ON DELETE CASCADE
);
