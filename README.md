## 📦 Installation de la base de données PostgreSQL

### 1. Créer la base de données

Connectez-vous à PostgreSQL avec votre utilisateur (par défaut `tp_user`), puis créez la base :

```bash
createdb -U tp_user fanfarehub
```

### 2. Importer les données

Assurez-vous d’être dans le dossier contenant fanfarehub_dump.sql, puis lancez :

```bash
psql -U tp_user -d fanfarehub -f fanfarehub_dump.sql
```

Cela va créer toutes les tables (appuser, event, participation, etc.) ainsi que les contraintes et données initiales.  
Assurez-vous que le fichier ConnexionBD.java contient les bons paramètres de connexion :

```bash
String url = "jdbc:postgresql://localhost:5432/fanfarehub";
String user = "tp_user";
String password = "<ton_mot_de_passe>";
```

Pour se connecter voici les utilisateurs existants :  
User n°1 :

- Username : julienlrzl@icloud.com
- Password : test
  User n°2 (Admin):
- Username : admin@site.com
- Password : adminpass  
  User n°3 :
- Username : victor.lefevre@gmail.com
- Password : test
