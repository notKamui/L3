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