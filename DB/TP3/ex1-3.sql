DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE test(
    a int,
    b int
);

INSERT INTO test VALUES
    (1, 1),
    (2, 2);

/* Exercice 1 */

/* 2 */
/* Erreur deadlock parce que pas d'isolation,
T2 essaie de modifier une ligne modifiée par T1
et s'attendent donc mutuellement */
/* REPEATABLE READ donne la même erreur */

/* 3 */
/* Incrémentation par les deux transactions sans erreur */
/* REPEATABLE READ cause une erreur de serialisation, seulement T1 a pu faire la transaction */

/* 4 */
/* surprenant, pas de délétion */
/* on aurait pu imaginer que le premier tuple serait supprimé */

/* Exercice 3 */
/*
1. la table pg_locks contient deux lignes
*/

/*
2. SELECT relfilenode FROM pg_class WHERE relname='test' ;

relfilenode = 24748
*/

/*
3. select locktype, tuple, virtualtransaction, mode from pg_locks where relation=24748;

aucun verrou actif
*/

/*
4.

Verrou AccessShareLock:
-Créés par les deux transactions lors de leur lecture de la table test.
-Non bloquant.
-Relâché lorsque la transaction termine.
-Pas d'enregistrement concerné.

Verrou RowExclusiveLock:
-Créés par les deux transaction lors des updates de la table.
-Non bloquant.
-Relâché lors de la transaction termine.
-Pas d'enregistrement concerné.

Verrou ExlcusiveLock
-Créé par la transaction 2 lors de sa tentative d'update de lignes modifiées
par la transaction 1.
-Bloquant.
-Relâche lorsque la transaction 1 (celle modifant potentiellement des lignes que l'on veut modifier)
termine sa transaction.
-Les enregistrements concernés sont ceux modifiés par la transaction 1.
*/

/*
6.

Update ->
    +AccessShareLock
    +RowExclusiveLock
    +SIReadLock

Insert ->
    +SIReadLock

Commit 1 ->
    -AccessShareLock
    -RowExclusiveLock

Commit 2 ->
    -SIReadLock

(aucun bloquant)
*/