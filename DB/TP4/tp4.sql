DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE test(
    id serial PRIMARY KEY,
    a int,
    b int
);

-- Exercice 1
-- 1
/*
ctid: localisation physique d'une colonne dans la table sous forme de tuple
xmin: id de la transaction qui a inséré cette de la ligne
xmax: id de la transaction de suppression
*/
-- 2
SELECT *, ctid, xmin, xmax FROM test;
INSERT INTO test(a, b) VALUES
    (1, 1),
    (2, 2);
SELECT *, ctid, xmin, xmax FROM test;
INSERT INTO test(a, b) VALUES
    (3, 3),
    (4, 4);
SELECT *, ctid, xmin, xmax FROM test;
-- 3
/*
xmin = txid_current()
pour chaque insertion dans une transaction
*/
-- 4
/*
xmax = txid_current() tant que les transactions ne sont pas commit
même après rollback, la valeur reste.
*/
-- 5
/*
xmin = txid_current() a chaque update
ctid s'incrémente globalement de 1 a chaque action, même update
*/

-- Exercice 2
-- 1
/*
ctid possède deux blocks, le deuxième est incrémenté à chaque insertion
*/
-- 2
INSERT INTO test(a,b)
    SELECT round(random()*10), round(random()*100)
    FROM generate_series(1,10000);
-- 3
/*
chaque bloc contient 185 enregistrements
*/
-- 4
/*
chaque bloc fait environ 185 * (7 + 3 + 1) * 4 = 8140 octets (+ x octets de header)
*/

-- Exercice 3
-- 1
/*
informations cohérentes
*/
-- 2
ANALYZE test;
SELECT relpages, reltuples FROM pg_class WHERE relname = 'test';
DELETE FROM test WHERE a < 5;
SELECT relpages, reltuples FROM pg_class WHERE relname = 'test';
/*
supprimer des enregistrements ne change pas la valeur de relpages
*/
-- 3
