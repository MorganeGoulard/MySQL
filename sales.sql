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





