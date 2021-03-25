/* EXERCICE 4 */
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

DROP TABLE IF EXISTS etudiant CASCADE;
DROP TABLE IF EXISTS cours CASCADE;
DROP TABLE IF EXISTS examen CASCADE;

CREATE TABLE etudiant (
	numEtud serial PRIMARY KEY,
	nom varchar(25) NOT NULL,
	prenom varchar(25) NOT NULL,
	numlic int
);

INSERT INTO etudiant(nom,prenom,numlic) VALUES
	('Potter', 'Harry', 2),
	('Granger', 'Hermione', 2),
	('Lovegood', 'Luna', 1),
	('Weasley', 'Ronald', 2),
	('Delacour', 'Fleur', 2);

CREATE TABLE cours (
	codeCours serial PRIMARY KEY,
	intitule varchar(60),
	ects int
);

INSERT INTO cours(intitule, ects) VALUES
	('Métamorphose', 20),
	('Potions', 15),
	('Défense contre les forces du mal', 15),
	('Enchantement', 20),
	('Points de jury', 30);

CREATE TABLE examen (
	numEtud int REFERENCES etudiant(numEtud),
	codeCours int REFERENCES cours(codeCours),
	note numeric(3,1),
	PRIMARY KEY (numEtud,codeCours)
);

INSERT INTO examen VALUES
	(1,1,12),
	(1,2,12),
	(1,3,12),
	(1,4,12),
	(5,4,15);

CREATE VIEW nouveauL3 AS
(
	SELECT numEtud, nom
	FROM etudiant NATURAL JOIN examen NATURAL JOIN cours
	WHERE note >= 10 AND numLic = 2
	GROUP BY numEtud, nom
	HAVING sum(ects) >= 60
);


CREATE OR REPLACE FUNCTION pointsJury() RETURNS TRIGGER AS
$$
    DECLARE 
        etu etudiant%ROWTYPE; deja int;
        jury cours%ROWTYPE;
        pts int;
    BEGIN
	PERFORM * FROM cours WHERE intitule = 'Points de jury';
	IF NOT FOUND THEN
		INSERT INTO cours(intitule, ects) VALUES ('Points de jury', 10);
	END IF;
    
    SELECT * INTO etu FROM etudiant WHERE numEtud = NEW.numEtud AND nom = NEW.nom;
    IF NOT FOUND THEN 
        RAISE NOTICE 'L''étudiant n''existe pas.';
        RETURN NULL;
    END IF;
    
    IF etu.numLic != 2 THEN 
        RAISE NOTICE 'L''étudiant n''est pas en L2.';
        RETURN NULL; 
    END IF;

    SELECT numEtud INTO deja FROM nouveauL3 WHERE numEtud = NEW.numEtud;
    IF FOUND THEN
        RAISE NOTICE '% passe déjà en L3.', etu.nom;
        RETURN NULL;
    END IF;

    SELECT * INTO jury FROM cours WHERE intitule = 'Points de jury';
    SELECT sum(ects) INTO pts FROM examen NATURAL JOIN cours WHERE numEtud = NEW.numEtud AND note >= 10;
    IF pts IS NULL THEN
        pts = 0;
    END IF;

    pts = pts + jury.ects;
    
    IF pts < 60 THEN
        RAISE NOTICE 'Que % points; tu repasses', pts;
        RETURN NULL;
    ELSE
        INSERT INTO examen VALUES (etu.numEtud, jury.codeCours, 10);
    END IF;
    
    RETURN NEW;
    
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insereL3
INSTEAD OF INSERT ON nouveauL3
FOR EACH ROW 
EXECUTE PROCEDURE pointsJury();

INSERT INTO nouveauL3 VALUES (5, 'Delacour');
INSERT INTO nouveauL3 VALUES (5, 'AA');