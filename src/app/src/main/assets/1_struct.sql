CREATE TABLE NUTRISCORE
   (
   NUT_CODE VARCHAR(1) NOT NULL,
   NUT_LIBELLE VARCHAR(50)  
,
     PRIMARY KEY (NUT_CODE)
   );

CREATE TABLE CODEEMBALLEUR
   (
   COD_ID INTEGER PRIMARY KEY AUTOINCREMENT,
   COD_LIBELLE VARCHAR(32)
   );

CREATE TABLE LIEU
   (
   LIEU_ID INTEGER PRIMARY KEY AUTOINCREMENT ,
   LIEU_LIBELLE VARCHAR(50)
   );

CREATE TABLE PAYS
   (
   PAY_CODE INTEGER PRIMARY KEY AUTOINCREMENT,
   PAY_LIBELLE VARCHAR(50)
   );

CREATE TABLE MARQUE
   (
   MAR_CODE INTEGER PRIMARY KEY AUTOINCREMENT ,
   MAR_LIBELLE VARCHAR(50)
   );

CREATE TABLE NOVA
   (
   NOVA_ID INTEGER NOT NULL ,
   NOVA_LIBELLE VARCHAR(50)
,
     PRIMARY KEY (NOVA_ID)
   );

CREATE TABLE LABEL
   (
   LAB_CODE INTEGER PRIMARY KEY AUTOINCREMENT,
   LAB_LIBELLE VARCHAR(50)
   );

   CREATE TABLE CATEG_NUTRISCORE
   (
   CN_ID INTEGER PRIMARY KEY AUTOINCREMENT,
   CN_LIBELLE VARCHAR(50)
   );

CREATE TABLE PRODUIT
   (
   PRO_ID INTEGER PRIMARY KEY AUTOINCREMENT ,
   PRO_LIBELLE VARCHAR(50)  ,
   COD_ID INTEGER  ,
   NOVA_ID INTEGER NOT NULL ,
   NUT_CODE VARCHAR(1) NOT NULL ,
   PRO_INGREDIENT VARCHAR(255)  ,
   PRO_LIEN VARCHAR(255)  ,
   PRO_QUANTITE INTEGER  ,
   PRO_ENERGIE INTEGER  ,
   PRO_MATIEREGRASSE DECIMAL(10,3)  ,
   PRO_ACIDEGRAS DECIMAL(10,2)  ,
   PRO_GLUCIDE DECIMAL(10,2)  ,
   PRO_SUCRE DECIMAL(10,2)  ,
   PRO_FIBRE DECIMAL(10,2)  ,
   PRO_PROTEINE DECIMAL(10,2)  ,
   PRO_SEL DECIMAL(10,2)  ,
   PRO_SODIUM DECIMAL(10,2),
   PRO_FRUIT DECIMAL(10,2),
   PROD_ID_CATEG_NUTRISCORE INTEGER NOT NULL,
   
     FOREIGN KEY (COD_ID) REFERENCES CODEEMBALLEUR (COD_ID),
     FOREIGN KEY (NOVA_ID) REFERENCES NOVA (NOVA_ID),
     FOREIGN KEY (NUT_CODE) REFERENCES NUTRISCORE (NUT_CODE),
     FOREIGN KEY (PROD_ID_CATEG_NUTRISCORE) REFERENCES CATEG_NUTRISCORE (CN_ID)
   );

CREATE  INDEX I_FK_PRODUIT_CODEEMBALLEUR
     ON PRODUIT (COD_ID ASC);

CREATE  INDEX I_FK_PRODUIT_NOVA
     ON PRODUIT (NOVA_ID ASC);

CREATE  INDEX I_FK_PRODUIT_NUTRISCORE
     ON PRODUIT (NUT_CODE ASC);

CREATE TABLE CATEGORIE
   (
   CAT_CODE INTEGER PRIMARY KEY AUTOINCREMENT,
   CAT_LIBELLE VARCHAR(50)
   );

CREATE TABLE MAGASIN
   (
   MAG_CODE INTEGER PRIMARY KEY AUTOINCREMENT,
   MAG_LIBELLE VARCHAR(32)
   );

CREATE TABLE ALLERGENE
   (
   ALL_CODE INTEGER PRIMARY KEY AUTOINCREMENT ,
   ALL_LIBELLE VARCHAR(32)
   );

CREATE TABLE CONDITIONNEMENT
   (
   CON_CODE INTEGER PRIMARY KEY AUTOINCREMENT,
   CON_LIBELLE VARCHAR(50)
   );

CREATE TABLE ADDITIF
   (
   ADD_ID INTEGER  PRIMARY KEY AUTOINCREMENT,
   ADD_LIBELLE VARCHAR(32)
   );

CREATE TABLE FABRIQUER
   (
   PRO_ID INTEGER NOT NULL ,
   LIEU_ID INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, LIEU_ID),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (LIEU_ID) REFERENCES LIEU (LIEU_ID)
   );

CREATE  INDEX I_FK_FABRIQUER_PRODUIT
     ON FABRIQUER (PRO_ID ASC);

CREATE  INDEX I_FK_FABRIQUER_LIEU
     ON FABRIQUER (LIEU_ID ASC);
     
CREATE TABLE CONSTITUER
   (
   ALL_CODE INTEGER NOT NULL ,
   PRO_ID INTEGER NOT NULL 
,
     PRIMARY KEY (ALL_CODE, PRO_ID),
     FOREIGN KEY (ALL_CODE) REFERENCES ALLERGENE (ALL_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID) 
   );
   
CREATE  INDEX I_FK_CONSTITUER_ALLERGENE
     ON CONSTITUER (ALL_CODE ASC);

CREATE  INDEX I_FK_CONSTITUER_PRODUIT
     ON CONSTITUER (PRO_ID ASC);

CREATE TABLE PROVENIR
   (
   PRO_ID INTEGER NOT NULL ,
   PAY_CODE INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, PAY_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (PAY_CODE) REFERENCES PAYS (PAY_CODE)
   );

CREATE  INDEX I_FK_PROVENIR_PRODUIT
     ON PROVENIR (PRO_ID ASC);

CREATE  INDEX I_FK_PROVENIR_PAYS
     ON PROVENIR (PAY_CODE ASC);

CREATE TABLE APPARTENIR
   (
   CAT_CODE INTEGER NOT NULL ,
   PRO_ID INTEGER NOT NULL 
,
     PRIMARY KEY (CAT_CODE, PRO_ID)  ,
     FOREIGN KEY (CAT_CODE) REFERENCES CATEGORIE (CAT_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID)
   );

CREATE  INDEX I_FK_APPARTENIR_CATEGORIE
     ON APPARTENIR (CAT_CODE ASC);

CREATE  INDEX I_FK_APPARTENIR_PRODUIT
     ON APPARTENIR (PRO_ID ASC);

CREATE TABLE COMMERCIALISER
   (
   MAG_CODE INTEGER NOT NULL ,
   PRO_ID INTEGER NOT NULL 
,
     PRIMARY KEY (MAG_CODE, PRO_ID),
     FOREIGN KEY (MAG_CODE) REFERENCES MAGASIN (MAG_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID)
   );

CREATE  INDEX I_FK_COMMERCIALISER_MAGASIN
     ON COMMERCIALISER (MAG_CODE ASC);

CREATE  INDEX I_FK_COMMERCIALISER_PRODUIT
     ON COMMERCIALISER (PRO_ID ASC);

CREATE TABLE STOCKER
   (
   CON_CODE INTEGER NOT NULL ,
   PRO_ID INTEGER NOT NULL 
,
     PRIMARY KEY (CON_CODE, PRO_ID),
     FOREIGN KEY (CON_CODE) REFERENCES CONDITIONNEMENT (CON_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID)
   );

CREATE  INDEX I_FK_STOCKER_CONDITIONNEMENT
     ON STOCKER (CON_CODE ASC);

CREATE  INDEX I_FK_STOCKER_PRODUIT
     ON STOCKER (PRO_ID ASC);

CREATE TABLE CERTIFIER
   (
   PRO_ID INTEGER NOT NULL ,
   LAB_CODE INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, LAB_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (LAB_CODE) REFERENCES LABEL (LAB_CODE)
   );

CREATE  INDEX I_FK_CERTIFIER_PRODUIT
     ON CERTIFIER (PRO_ID ASC);

CREATE  INDEX I_FK_CERTIFIER_LABEL
     ON CERTIFIER (LAB_CODE ASC);

CREATE TABLE VENDRE
   (
   PRO_ID INTEGER NOT NULL ,
   PAY_CODE INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, PAY_CODE),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (PAY_CODE) REFERENCES PAYS (PAY_CODE)
   );

CREATE  INDEX I_FK_VENDRE_PRODUIT
     ON VENDRE (PRO_ID ASC);

CREATE  INDEX I_FK_VENDRE_PAYS
     ON VENDRE (PAY_CODE ASC);

CREATE TABLE ETRE
   (
   PRO_ID INTEGER NOT NULL ,
   MAR_CODE INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, MAR_CODE)  ,
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (MAR_CODE) REFERENCES MARQUE (MAR_CODE)
   );

CREATE  INDEX I_FK_ETRE_PRODUIT
     ON ETRE (PRO_ID ASC);

CREATE  INDEX I_FK_ETRE_MARQUE
     ON ETRE (MAR_CODE ASC);

CREATE TABLE CONTENIR
   (
   PRO_ID INTEGER NOT NULL ,
   ADD_ID INTEGER NOT NULL 
,
     PRIMARY KEY (PRO_ID, ADD_ID),
     FOREIGN KEY (PRO_ID) REFERENCES PRODUIT (PRO_ID),
     FOREIGN KEY (ADD_ID) REFERENCES ADDITIF (ADD_ID)
   );

CREATE  INDEX I_FK_CONTENIR_PRODUIT
     ON CONTENIR (PRO_ID ASC);

CREATE  INDEX I_FK_CONTENIR_ADDITIF
     ON CONTENIR (ADD_ID ASC);



