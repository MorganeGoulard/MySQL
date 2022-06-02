
-- Authentification/connexion 
>mysql -u root -- si l'utilisateur n'a pas de mdp 
>mysql -u root -p -- si l'utilisateur possède un mdp 

-- 1. Lister toutes les bases de données 

SHOW DATABASES;

-- 2. création de la base de données 

CREATE DATABASE poe_ventes;

-- 3. utiliser/sélectionner une base de données 
-- USE <nom base_de_données>
USE poe_ventes;

-- 4. Lister les tables de la base de données

SHOW TABLES;

-- 5. création de la table de données 
-- INTEGER : c'est le type entier 
-- NOT NULL : cette colonne doit toujours contenir une info 
-- AUTO_INCREMENT : Dire à MySQL de fournir des valeurs en incrémentant 
--                  automatiquement les clés 
-- PRIMARY KEY : Marquer la colonne comme étant la clé primaire 
-- UNIQUE : pour appliquer une contrainte d'unicité
CREATE TABLE clients(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 nom VARCHAR(50) NOT NULL,
 prenom VARCHAR(50) NOT NULL,
 email VARCHAR (70),
 telephone VARCHAR (20) NOT NULL   
);

-- Voir la description de la table 
-- DESC <nom_table> ou DESCRIBE <nom_table>