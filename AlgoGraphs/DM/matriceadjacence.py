#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Implémentation d'un graphe à l'aide d'une matrice d'adjacence. Les n sommets
sont identifiés par de simples naturels (0, 1, 2, ..., n-1)."""


class MatriceAdjacence(object):
    def __init__(self, num=0):
        """Initialise un graphe sans arêtes sur num sommets.

        >>> G = MatriceAdjacence()
        >>> G._matrice_adjacence
        []
        """
        self._matrice_adjacence = [[0] * num for _ in range(num)]

    def ajouter_arete(self, source, destination):
        """Ajoute l'arête {source, destination} au graphe, en créant les
        sommets manquants le cas échéant.
        
        >>> G = MatriceAdjacence(2)
        >>> G._matrice_adjacence
        [[0, 0], [0, 0]]
        >>> G.ajouter_arete(0, 1)
        >>> G._matrice_adjacence
        [[0, 1], [1, 0]]
        """
        self._matrice_adjacence[source][destination] = 1
        self._matrice_adjacence[destination][source] = 1

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels."""
        for arete in iterable:
            self.ajouter_arete(arete[0], arete[1])

    def ajouter_sommet(self):
        """Ajoute un nouveau sommet au graphe et renvoie son identifiant.

        >>> G = MatriceAdjacence()
        >>> G.ajouter_sommet()
        0
        >>> G._matrice_adjacence
        [[0]]
        >>> G.ajouter_sommet()
        1
        >>> G._matrice_adjacence
        [[0, 0], [0, 0]]
        """
        new = MatriceAdjacence(self.nombre_sommets()+1)
        for i in range(0, self.nombre_sommets()+1):
            for j in range(0, self.nombre_sommets()+1):
                new[j][i] = self._matrice_adjacence[j][i]
        self._matrice_adjacence = new._matrice_adjacence
        return self.nombre_sommets()

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u))."""
        ret = []
        for i in range(0, len(self._matrice_adjacence)):
            for j in range(0, len(self._matrice_adjacence)-1-i):
                if self._matrice_adjacence[j][i] == 1:
                    ret.append([i, j])
        return ret

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        ret = []
        for i in range(0, len(self._matrice_adjacence)):
            if self._matrice_adjacence[i][i] == 1:
                ret.append([i, i])
        return ret

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        return self._matrice_adjacence[u][v] == 1

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u < self.nombre_sommets()

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède."""
        tmp = self._matrice_adjacence[sommet]
        count = 0
        for i in range(0, self.nombre_sommets()):
            if tmp[i] == 1:
                count += 1
        return count

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe."""
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return len(self.boucles())

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe.

        >>> from random import randint
        >>> n = randint(0, 1000)
        >>> MatriceAdjacence(n).nombre_sommets() == n
        True
        """
        return len(self._matrice_adjacence)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon."""
        if self._matrice_adjacence[v][u] == 0:
            raise Exception("Cette arête n'existe pas")
        self._matrice_adjacence[v][u] = 0
        self._matrice_adjacence[u][v] = 0

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for arete in iterable:
            self.retirer_arete(arete[0], arete[1])

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime."""
        for i in range(0, self.nombre_sommets()):
            self.retirer_arete(sommet, i)
        # TODO


    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        pass  # à compléter

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        pass  # à compléter

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet."""
        tmp = self._matrice_adjacence[sommet]
        ret = []
        for i in range(0, self.nombre_sommets()):
            if tmp[i] == 1:
                ret.append(i)
        return ret


def export_dot(graphe):
    """Renvoie une chaîne encodant le graphe au format dot."""
    return ""  # à compléter


def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
