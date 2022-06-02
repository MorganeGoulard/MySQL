
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