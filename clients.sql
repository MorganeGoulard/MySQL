
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
DESC clients;

-- Modifier une table en ajoutant une nouvelle colonne
ALTER TABLE clients ADD COLUMN postnom VARCHAR(50); 

-- Modifier une table en ajoutant une nouvelle colonne après une autre
-- on rajoute la colonne "postnom" après la colonne "prénom" 
ALTER TABLE clients MODIFY COLUMN postnom VARCHAR(50) AFTER prenom;


-- LMD 

-- Lister (SELECT) les infos de toutes (*) les colonnes de la table (FROM) client

SELECT * FROM clients;

-- Insertion des données
INSERT INTO clients(nom,prenom,email,telephone)
values("DUMORTIER","Steven","stevenexemple@gmail.com","0600000000"),
("VAULIN", "Ludovic", "ludovicexemple@gmail.com", "0601010101");

-- Ajout d'une colonne age (2 chiffres max)
ALTER TABLE clients ADD COLUMN age INTEGER(2); 

-- Mise à jour des données 
UPDATE clients SET telephone="0673460896" where ID=2;

-- Mise à jour données mais sur plusieurs champs 
UPDATE clients SET postnom="Tarzan",age=17 where ID=3;

-- Supprimer un enregistrement 
DELETE FROM clients WHERE ID=3;

-- configurer MYSQL en mode strict 
-- Valeur pour le mode strict : STRICT_TRANS_TABLES
--> vérifier le mode de transaction 
SHOW VARIABLES LIKE 'sql_mode';

--> Définir le mode strict pour le mode de transaction 
set sql_mode='STRICT_TRANS_TABLES';

-- Filtres 
SELECT * FROM clients WHERE age>20;
SELECT * FROM clients WHERE age>20 AND prenom="Morgane";

-- Création d'une nouvelle table avec relation
CREATE TABLE telephones(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY
    numero VARCHAR(20) NOT NULL,
    id_clients INTEGER,
    FOREIGN KEY (id_clients) REFERENCES clients(ID) ON DELETE CASCADE
    );
-- ON DELETE CASCADE : si on supprime le client, tous les num associés sont suppr 
-- ON DELETE SET NULL : le client est supprimé, mais le champ est marqué comme NULL mais gardé 
-- ON DELETE RESTRICT : si on essaie de suppr n° tel, tant que c'est associé à un client, ERROR
--                      pas la possiblité de faire cette action 
-- ON UPDATE CASCADE : si ID de table clients modifiée, mise à jour sur table telephone

-- Supprimer une colonne d'une base de données
ALTER TABLE clients DROP COLUMN telephones;

-- Supprimer BDD : DROP DATABASE poe_ventes
-- Supprimer table : DROP TABLE clients 

-- Insérer plusieurs numéros : 
INSERT INTO telephones (numero, id_clients) 
values (0203040506,2), (0605040302,1), (0605040309,1), (0605040333,2), (0603340302,3), 
(0654040302,3), (0605540302,5), (0605047702,5), (0605049902,5), (0606740302,5), (0605547102,6),
 (0611047702,6), (0605049872,6);

 -- Afficher les numéros de telephone de tous les clients
 -- requête multi-table 
 -- tables sollicitées : clients et telephones 

 SELECT clients.prenom, clients.nom, telephones.numero FROM clients JOIN telephones
 ON clients.id=telephones.id_clients;
 -- INNER JOIN ou JOIN c'est la même chose 
 -- ON clients.id=telephones.id_clients : c'est ici qu'on dit qu'on veut lier id de clients qui
 -- correspond à id_clients de telephones

 -- jointure et concaténation 
 SELECT CONCAT (clients.prenom, " ", clients.nom) AS nom, clients.email, telephones.numero FROM 
 clients JOIN telephones ON clients.id=telephones.id_clients WHERE clients.id=1;

