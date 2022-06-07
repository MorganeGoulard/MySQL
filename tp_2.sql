CREATE DATABASE tp_2;
USE tp_2;

CREATE TABLE clients(
id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
companyName VARCHAR (30) NOT NULL, 
firstName VARCHAR (30) NOT NULL, 
lastName VARCHAR (30) NOT NULL,
email VARCHAR (70) NOT NULL,
phone VARCHAR (30) NOT NULL,
address VARCHAR (150) NOT NULL,
zipCode VARCHAR (10) NOT NULL,
city VARCHAR (30) NOT NULL,
country VARCHAR (30) NOT NULL,
state INTEGER (1) NOT NULL
);

CREATE TABLE orders(
id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
typePresta VARCHAR (30) NOT NULL, 
designation VARCHAR (30) NOT NULL, 
clientId INTEGER NOT NULL, FOREIGN KEY (clientId) REFERENCES clients(id) ON DELETE RESTRICT,
nbDays INTEGER NOT NULL,
unitPrice FLOAT(10,2)
state INTEGER (1) NOT NULL
);

INSERT INTO clients (companyName,firstName,lastName,email,phone,address,zipCode,city,country,state)
values ("Capgemini","Fabrice","Martin","martin@mail.com","06 56 85 84 33", "abc", "xyz","Nantes","France",0),
("M2I Formation", "Julien", "Lamard", "lamard@mail.com", "06 11 22 33 44", "abc", "xyz", "Paris", "France",1),
("ATOS", "Jean", "Zozor", "jzozor@mail.com", "06 09 08 07 06", "quelque part", "tre", "Bastia", "France", 1),
("SOPRA STRERIA", "Morgane", "Goulard", "morgane@mail.com", "06 02 03 04 05", "chez moi", "sfu", "Rennes", "France", 0);

INSERT INTO orders(typePresta,designation,clientId,nbDays,unitPrice,state) 
values ("Formation", "Angular init",2,3,1200,0), ("Formation", "React avancé",2,3,1000,2),
("Coaching", "React Techlead",1,20,900,2), ("Coaching","Nest.js Techlead",1,50,800,1), ("Coaching", "React Teachead",3,30,1400,1),
("Coaching", "Jakarta EE",3,6,500,0), ("Coaching", "Angular",4,10,1800,2),("Formation", "React Techlead",1,25,500,2), 
("Formation", "Jakarta EE",2,7,2000,1), ("Coaching", "Angular",4,22,1250,0);


-- Afficher toutes les formations sollicitées par le client M2i Formation
SELECT orders.typePresta,orders.designation FROM orders WHERE clientId=2;

-- Afficher les noms et contacts de tous les contacts des clients qui ont sollicités un coaching
SELECT DISTINCT CONCAT (clients.firstName, " ", clients.lastName) AS noms, 
CONCAT(clients.email,"/", clients.phone) AS contact, orders.typePresta 
FROM clients JOIN orders ON clients.id=orders.clientId 
where orders.typePresta="Coaching";

-- Afficher les noms et contacts de tous les contacts des clients qui ont sollicités un 
-- coaching pour les accompagnatns React.js
SELECT CONCAT (clients.firstName, " ", clients.lastName) AS noms, CONCAT(clients.email,"/", clients.phone) AS contact,
orders.designation FROM clients JOIN orders ON clients.id=orders.clientId where orders.designation="Nest.js Techlead";

-- Question sur les vues 
CREATE VIEW priceTotal AS SELECT 
CONCAT(typePresta," ",designation) AS prestation,
CONCAT(unitPrice*nbDays," €") AS totalExcludeTaxe,
CONCAT(unitPrice*nbDays*1.2," €") AS totalWithTaxe,
state
FROM orders;

-- Lister toutes les prestations qui sont confirmées et qui vont rapporter plus de 30.000€
SELECT orders.state, TotalWithTaxe FROM v_taxes,orders where orders.state=2 AND (unitPrice*nbDays) >= 30000;




