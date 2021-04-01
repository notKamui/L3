DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

/* Exercice 1 */

CREATE TABLE test(
	id serial primary key,
	a int,
	b int
);

INSERT INTO test(a, b) VALUES (1, 2) RETURNING id;
INSERT INTO test VALUES (1, 1, 2) RETURNING id;
/* Interdit car contrainte primary key */

BEGIN;
INSERT INTO test(a, b) VALUES (1, 3);
INSERT INTO test(a, b) VALUES (1, 4);
INSERT INTO test(a, b) VALUES (1, 5);
SELECT * FROM test;
ROLLBACK;
SELECT * FROM test; 
/* 
Une transaction, tant que non validée, est temporaire et donc annulable 
Propriété Atomicité
Même principe avec une "panne"
> tout ou rien
*/

BEGIN;
INSERT INTO test(a, b) VALUES (1, 3);
INSERT INTO test(a, b) VALUES (1, 4);
INSERT INTO test(a, b) VALUES (1, 5);
SELECT * FROM test;
COMMIT;
SELECT * FROM test;
/* commit effectué */

BEGIN;
INSERT INTO test(a, b) VALUES (2, 5);
INSERT INTO test VALUES (7, 2, 9);
/* erreur -> rollback requis */
ROLLBACK;
SELECT * FROM test;

BEGIN;
INSERT INTO test(a, b) VALUES (2, 5);
INSERT INTO test VALUES (7, 2, 9);
COMMIT;
/* commit ignoré, équivalent a rollback à cause de l'erreur */
SELECT * FROM test;

BEGIN;
INSERT INTO test(a, b) VALUES (2, 5);
/* INSERT INTO tst VALUES (7, 2, 9); */
/* erreur dans le script, donc abort complet */
COMMIT;
SELECT * FROM test;

/* Exercice 2 */
CREATE TABLE projet(
	pid serial primary key,
	titre varchar(50),
	statut varchar(15),
	requis int
);

CREATE TABLE soutient(
	uid int,
	pid int references projet(pid),
	montant int
);

INSERT INTO projet VALUES
	(1,'Hoverboard','attente',50000),
	(2,'Full body VR','attente',10000),
	(3,'Perpetual motion','attente',500);

INSERT INTO soutient VALUES
	(2,2,6000);

/* tests ->
READ UNCOMMITTED: dirty read pas postgres; non repeat read ok; phantom ok; ser anomaly ok
READ COMMITTED: dirty read impossible; non repeat read ok; phantom ok; ser anomaly ok
REPEATABLE READ: dirty read impossible; non repeat read impossible; phantom pas postgres; ser anomaly ok
SERIALIZABLE: dirty read impossible; non repeat read impossible; phantom impossible; ser anomaly impossible
*/

/* Exercice 3 */

CREATE OR REPLACE FUNCTION test_trig_fn()
RETURNS TRIGGER AS
$$
	BEGIN
		IF NEW.a % 2 = 0 THEN
			RAISE NOTICE 'a est pair';
		END IF;

		IF NEW.b % 2 = 0 THEN
			RETURN NULL;
		END IF;

		IF NEW.a = NEW.b THEN
			RAISE EXCEPTION 'b est pair !!!';
		END IF;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER test_trig
BEFORE INSERT ON test
FOR EACH ROW
EXECUTE PROCEDURE test_trig_fn();

SELECT * FROM test;

BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(2, 3),
	(5, 9);
ROLLBACK;
BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(2, 3),
	(5, 9);
COMMIT;

SELECT * FROM test;

BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(1, 2),
	(5, 9);
ROLLBACK;
BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(1, 2),
	(5, 9);
COMMIT;

SELECT * FROM test;

BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(1, 1),
	(5, 9);
ROLLBACK;
BEGIN;
INSERT INTO test(a, b) VALUES 
	(1, 3),
	(1, 1),
	(5, 9);
COMMIT;

SELECT * FROM test;

/*
Une notice ne fait rien sur la transaction
Un retour null est considéré valide, mais rien n'est inséré
Une exception est considérée comme une erreur
*/

/* Exercice 4 */
BEGIN;
CREATE TABLE testB(
	id serial primary key,
	a int,
	b int
);
\d
ROLLBACK;
\d
BEGIN;
CREATE TABLE testb(
	id serial primary key,
	a int,
	b int
);
\d
COMMIT;

/* Postgres ne fait pas de commit implicite sur une création de table, on peut donc rollback */


BEGIN;
ALTER TABLE testb RENAME COLUMN a TO z;
\d testb
ROLLBACK;
\d testb
BEGIN;
ALTER TABLE testb RENAME COLUMN a TO z;
\d testb
COMMIT;

/* Postgres ne fait pas de commit implicite sur un renommage de colonne, on peut donc rollback */

BEGIN;
ALTER TABLE testb ALTER COLUMN b TYPE varchar(255);
\d testb
ROLLBACK;
\d testb
BEGIN;
ALTER TABLE testb ALTER COLUMN b TYPE varchar(255);
\d testb
COMMIT;

/* Postgres ne fait pas de commit implicite sur un changement de type, on peut donc rollback */

BEGIN;
ALTER TABLE testb ADD CONSTRAINT fk_za FOREIGN KEY (z) REFERENCES test(id);
\d testb
ROLLBACK;
\d testb
BEGIN;
ALTER TABLE testb ADD CONSTRAINT fk_za FOREIGN KEY (z) REFERENCES test(id);
\d testb
COMMIT;

/* Postgres ne fait pas de commit implicite sur un ajout de contrainte, on peut donc rollback */
