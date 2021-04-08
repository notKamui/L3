DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE partie(
	pid serial primary key,
	jeu varchar(50),
	nbmin int,
	nbmax int,
	etat varchar(10) default 'ouvert',
	CHECK (nbmin <= nbmax)
);

CREATE TABLE joueur(
	jid serial primary key,
	pseudo varchar(25)
);

CREATE TABLE demande(
	jid int REFERENCES joueur(jid),
	pid int REFERENCES partie(pid),
	date timestamp default now(),
	statut varchar(10) default 'en attente',
	PRIMARY KEY(jid,pid)
);

INSERT INTO partie(jeu,nbmin,nbmax) VALUES
	('La guerre des moutons', 2, 4),
	('La guerre des moutons', 2, 4),
	('Dixit', 2, 5),
	('Elxiir', 4, 10),
	('Scythe',5,5),
	('Scythe',2,5),
	('Spirit Island',2,4),
	('Dominion',2,2),
	('7 wonders',3,7),
	('Ghost Stories',1,5);

INSERT INTO joueur(pseudo) VALUES
	('Alix'),
	('Bobar'),
	('Charpie'),
	('DiAnne'),
	('Eve-il');

INSERT INTO demande(jid,pid) VALUES
	(1,8), (2,8),
	(1,2), (2,2), (3,2);

/* Exercice 2 */
/*1*/
/* T1 Joueur T2 Admin
T1: BEGIN;
T2: BEGIN;
T1 et T2: SELECT * FROM partie; SELECT * FROM demande;
T2: UPDATE partie SET etat = 'fermé' WHERE pid = 8;
T2: UPDATE demande SET statut = 'validé' WHERE pid = 8;
T1: DELETE FROM demande WHERE jid = 1 and pid = 8;
T1: COMMIT;
T2: COMMIT;
*/

/*2*/
/* T1 Joueur T2 Admin
T1: BEGIN;
T2: BEGIN;
T1 et T2: SELECT * FROM partie; SELECT * FROM demande;
T2: UPDATE partie SET etat = 'annulé' WHERE pid = 8;
T2: UPDATE demande SET statut = 'refusé' WHERE pid = 8;
T1: INSERT INTO demande VALUES (3, 8);
T1: COMMIT;
T2: COMMIT;
*/

/*3*/
/* T1 Admin1 T2 Admin2
T1: BEGIN;
T2: BEGIN;
T1 et T2: SELECT * FROM partie; SELECT * FROM demande;
T1: UPDATE partie SET etat = 'fermé' WHERE pid = 8;
T2: UPDATE partie SET etat = 'annulé' WHERE pid = 8;
T1: UPDATE demande SET statut = 'validé' WHERE pid = 8;
T1: COMMIT;
T2: UPDATE demande SET statut = 'refusé' WHERE pid = 8;
T2: COMMIT;
*/

