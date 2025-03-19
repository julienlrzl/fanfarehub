## Projet Fanfarehub

### 📌 Installation de la Base de Données PostgreSQL

Ce guide explique comment installer et configurer la base de données PostgreSQL pour le projet **FanfareHub** à l'aide des fichiers SQL fournis.

---

### **1. Prérequis**

Avant de commencer, assurez-vous d'avoir :

- **PostgreSQL** installé sur votre machine.
- Accès à un terminal.
- Les fichiers SQL situés dans `src/resources/db/`.

---

### **2. Lancer PostgreSQL**

Démarrez le service PostgreSQL si ce n'est pas déjà fait :

```bash
brew services start postgresql  # (Mac)
```

Vérifiez que PostgreSQL fonctionne :

```bash
psql -U postgres
```

---

### **3. Exécuter les fichiers SQL pour créer la base**

**a- Créer la base de données** :

```bash
psql -U postgres -f src/resources/db/1_create_db.sql
```

**b- Créer les tables** :

```bash
psql -U postgres -d fanfarehub -f src/resources/db/2_create_tables.sql
```

**c- Insérer les données initiales** :

```bash
psql -U postgres -d fanfarehub -f src/resources/db/3_insert_data.sql
```

---

### **4. Vérifier l’installation**

Après l’installation, connectez-vous à PostgreSQL :

```bash
psql -U postgres -d fanfarehub
```

Puis vérifiez que les tables existent avec :

```sql
\dt
```

Et que les données ont été insérées avec :

```sql
SELECT * FROM "user";
```

Si les résultats affichent la liste des utilisateurs, l’installation est **réussie**.

---
