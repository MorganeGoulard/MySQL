-- 1. Création base de données sales 
show DATABASES;
CREATE DATABASE sales; 
SHOW DATABASE; 
USE clients;

-- 2. Créer table appelée téléphones avec colonne name, manufacturer, price, units_solds 

CREATE TABLE telephones(ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR (50) NOT NULL, 
manufacturer VARCHAR (50) NOT NULL, 
price FLOAT NOT NULL, 
units_solds FLOAT NOT NULL,
);
DESC telephones;

-- 3. Insérer les données 
INSERT INTO telephones(name,manufacturer,price,units_solds)
values ("N1280","Nokia",199,1925),("Iphone 4","Apple",399,9436),
("Galaxy S 5","Samsung",299,2359),("S5620 Monte","Samsung",250,2385),
("N8","Nokia",150,7543),("Droid","Motorala",150,8395),("Iphone 13 Pro Max","Apple",1300,12849),
("Galaxy Note 20","Samsung",1100, 10353);

-- 4. Lister tous les téléphones
SELECT * FROM telephones;

-- 5. Lister tous les téléphones (name,manufacturer) dont le prix>200€
select name, manufacturer from telephones where price>=200;

--6. Lister les téléphones (name,manufacturer) dont prix varie entre 150 et 200€
select name, manufacturer from telephones where price>=150 and price<=200;

-- alternative : 
SELECT name,manufacturer,price FROM telephones WHERE price BETWEEN 150 AND 200;

--7. Lister les téléphones de marquer samsung et Apple 
select * from telephones where manufacturer="Samsung" or manufacturer="Apple";

-- autre façon de faire : 
SELECT * FROM telephones WHERE manufacturer IN("Apple","Samsung"); 

-- Afficher dans l'ordre croissance des prix
SELECT name,manufacturer,price FROM telephones ORDER BY price ASC;
-- pour prix décroissant : price DESC 

-- Plusieurs filtres avec ordre 
SELECT name,manufacturer,price FROM telephones ORDER BY price DESC, manufacturer DESC;

-- produit du champ price+units_sold 
SELECT name,manufacturer,price, units_sold, price*units_solds FROM telephones;

-- Renommer les colonnes dans l'affichage avec AS (alias)
SELECT name AS modele, manufacturer AS constructor, price AS prix, 
units_solds AS unites_vendues, (price*units_solds) AS CA FROM telephones;
-- on peut aussi écrire price*units_solds AS "Chiffre d'affaire" mais pas du tout
-- recommandé

-- concaténation entre champs manufacturer + name et price et "€" grâce ) CONCAT 
-- CONCAT (manufacturer, name) --> pas d'espace dans l'affichage entre les 2, donc 
--                                  on ajoute " " entre les 2. 
SELECT CONCAT (manufacturer, " ", name) AS nom, CONCAT (price, "€") AS prix FROM telephones; 

-- petit exercice application  
SELECT CONCAT (name, " ", manufacturer) AS modele, CONCAT (price, " ", "€") AS prix, units_solds AS unites_vendues, 
CONCAT ((price*units_solds), " ", "€") AS CA FROM telephones;

-- Création d'une vue 
CREATE VIEW v_revenu_total AS SELECT name AS modele, manufacturer AS constructor, 
price AS prix, units_solds AS unites_vendues, (price*units_solds) AS CA FROM telephones;
-- Affichage vue 
SELECT * FROM v_revenu_total;

--Eviter la redondance 
SELECT DISTINCT(manufacturer) FROM telephones; -- Va afficher la liste des contructeurs sans répétitions

-- Afficher le nombre d'enregistrement
SELECT COUNT(*) FROM telephones
-- Afficher nombre d'appareil Apple 
SELECT COUNT(*) FROM telephones WHERE manufacturer="Apple";

-- Total des ventes
SELECT SUM(units_solds) AS Total_Ventes FROM telephones; 
-- Moyenne des ventes
SELECT AVG(units_solds) AS Moyenne_Ventes FROM telephones;
-- Ventes les + élevées 
SELECT MAX(units_solds) AS Ventes_plus_elevée FROM telephones;
-- Ventes les - elevées 
SELECT MIN(units_solds) AS Ventes_plus_elevée FROM telephones;

-- Nombre de ventes pour tous les fabricant
SELECT manufacturer,SUM(units_sold) FROM telephones GROUP BY manufacturer;
-- CA par fabricant
SELECT manufacturer,SUM(price*units_sold) as chiffre_affaire 
FROM telephones GROUP BY manufacturer;
-- CA par fabricant dans l'ordre decroissant des CA
SELECT manufacturer,SUM(price*units_sold) as chiffre_affaire 
FROM telephones GROUP BY manufacturer ORDER BY chiffre_affaire DESC;
-- Toutes les ventes des marques qui ont réalisé un CA > 20 000 000€
-- ici WHERE ne marchera pas car la condition utilise une condition d'application,
-- HAVING va permettre d'utiliser la valeur de l'alias CA
SELECT manufacturer, SUM(price*units_solds) as chiffre_affaire 
FROM telephones GROUP BY manufacturer HAVING chiffre_affaire > 20000000 ; 

-- On veut lister les téléphones dont le prix > moyenne 
-- Utilisation d'une query dans une requête 
SELECT name, price FROM telephones 
WHERE price > (SELECT AVG(price) FROM telephones) ORDER BY price DESC;

