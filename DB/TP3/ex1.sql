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