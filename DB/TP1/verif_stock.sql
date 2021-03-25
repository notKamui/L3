DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
\i magasin_trigger.sql

CREATE OR REPLACE FUNCTION majStock()
RETURNS TRIGGER AS
$$
	DECLARE
		mag int;
		sto stocke%ROWTYPE;
	BEGIN
		SELECT idmag INTO mag FROM facture WHERE idfac = NEW.idfac;

		RAISE NOTICE 'Le magasin concerné est le magasin %', mag;

		SELECT * INTO sto FROM stocke WHERE idmag = mag AND idpro = NEW.idpro;
		IF NOT FOUND THEN
			RAISE NOTICE 'Le magasin % ne vend pas le produit %.', mag, NEW.idpro;
			RETURN NULL;
		ELSEIF NEW.quantite > sto.quantite THEN
			RAISE NOTICE 'Le magasin n a plus que % unités du produit % en stock.', sto.quantite, NEW.idpro;
			NEW.quantite = sto.quantite;	
		END IF;

		UPDATE stocke
		SET quantite = (quantite - NEW.quantite)
		WHERE idmag = mag AND idpro = NEW.idpro;

		NEW.prixunit = sto.prixunit;

		RETURN NEW ;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verif_stock
BEFORE INSERT ON contient
FOR EACH ROW
EXECUTE PROCEDURE majStock();

/* EXERCICE 1 */
ALTER TABLE contient ENABLE TRIGGER verif_stock;
INSERT INTO contient VALUES(0, 0, 20, 2);

ALTER TABLE contient DISABLE TRIGGER verif_stock;
INSERT INTO contient VALUES(0, 1, 20, 2);

/* ce trigger avant chaque insert sur la table contient,
vérifie que le magasin concerné vend bien le produit donné.
si ce n'est pas le cas, alors l'insertion n'est pas effectuée */

ALTER TABLE contient ENABLE TRIGGER verif_stock;
SELECT * FROM stocke WHERE idmag = 44 AND idpro = 193;
INSERT INTO contient VALUES(0, 193, 20, 20000);
SELECT * FROM stocke WHERE idmag = 44 AND idpro = 193;
SELECT * FROM contient WHERE idfac = 0 AND idpro = 193;


/* EXERCICE 2 */

DROP TABLE IF EXISTS historiquePrix;
CREATE TABLE historiquePrix (
    log_id serial primary key,
    date date,
    idmag int references magasin(idmag),
    idpro int references produit(idpro),
    ancienPrix numeric(5,2),
    nouveauPrix numeric(5,2)
);

CREATE OR REPLACE FUNCTION majPrix()
RETURNS TRIGGER AS
$$
	DECLARE
		best record;
	BEGIN
		INSERT INTO historiquePrix 
		VALUES (DEFAULT, NOW(), NEW.idmag, NEW.idpro, OLD.prixunit, NEW.prixunit);

		RAISE NOTICE 'Le prix du produit % du magasin % est passé de % à %', NEW.idpro, NEW.idmag, OLD.prixunit, NEW.prixunit;

		PERFORM * FROM stocke WHERE prixunit < NEW.prixunit;
		IF NOT FOUND THEN
			RAISE NOTICE 'Ce produit est au meilleur prix du marché';
			SELECT nom, ville, idpro, libelle INTO best
			FROM stocke NATURAL JOIN produit NATURAL JOIN magasin;
			RAISE NOTICE 'Il est vendu chez % à % (%: %)', best.nom, best.ville, best.idpro, best.libelle;
		END IF;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER on_update_prix
BEFORE UPDATE ON stocke
FOR EACH ROW
WHEN (OLD.prixunit <> NEW.prixunit)
EXECUTE PROCEDURE majPrix();

SELECT * FROM historiquePrix;
UPDATE stocke SET prixunit = 10.00 WHERE idmag = 44 AND idpro = 193;
SELECT * FROM historiquePrix;
UPDATE stocke SET prixunit = 0.50 WHERE idmag = 44 AND idpro = 193;
SELECT * FROM historiquePrix;

/* EXERCICE 3 */

DROP TRIGGER IF EXISTS majFid ON contient;
DROP FUNCTION IF EXISTS majFid_fun;

CREATE OR REPLACE FUNCTION majFid_fun()
RETURNS TRIGGER AS
$$
    DECLARE
		res record;
    BEGIN
		SELECT prixunit, quantite, numcli, idmag INTO res
		FROM contient NATURAL JOIN facture
		WHERE idfac = NEW.idfac AND idpro = NEW.idpro;

		PERFORM * FROM fidelite
		WHERE numcli = res.numcli AND idmag = res.idmag;
		IF NOT FOUND THEN
			RAISE NOTICE 'Client n% aurait pu gagner % points', res.numcli, res.prixunit*res.quantite;
		ELSE
			RAISE NOTICE 'Client n% a gagné % points', res.numcli, res.prixunit*res.quantite;
			UPDATE fidelite
			SET points = points + (res.prixunit * res.quantite)
			WHERE numcli = res.numcli AND idmag = res.idmag;
		END IF;

		RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER majFid
AFTER INSERT ON contient
FOR EACH ROW
EXECUTE PROCEDURE majFid_fun();

SELECT * FROM fidelite WHERE numcli = 26 AND idmag = 85;
INSERT INTO contient VALUES (8, 192, 10, 5);
SELECT * FROM fidelite WHERE numcli = 26 AND idmag = 85;



DROP TRIGGER IF EXISTS ceilFid ON fidelite;
DROP FUNCTION IF EXISTS ceilFid;

CREATE OR REPLACE FUNCTION ceilFid_fun()
RETURNS TRIGGER AS
$$
    BEGIN
		RAISE NOTICE 'Plafond à 1000 atteint par la carte n%', NEW.numcarte;
		NEW.points = 1000;

		RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER ceilFid
BEFORE UPDATE OR INSERT ON fidelite
FOR EACH ROW
WHEN (NEW.points > 1000)
EXECUTE PROCEDURE ceilFid_fun();

SELECT * FROM fidelite WHERE numcli = 26 AND idmag = 85;
INSERT INTO contient VALUES (8, 10, 100, 100);
SELECT * FROM fidelite WHERE numcli = 26 AND idmag = 85;
