#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Implémentation d'un graphe à l'aide d'une liste d'adjacence. Les n sommets
sont identifiés par de simples naturels (0, 1, 2, ..., n-1)."""


class ListeAdjacence(object):
    def __init__(self, num=0):
        """Initialise un graphe sans arêtes sur num sommets.

        >>> G = ListeAdjacence()
        >>> G._liste_adjacence
        []
        """
        self._liste_adjacence = [list() for _ in range(num)]

    def ajouter_arete(self, source, destination):
        """Ajoute l'arête {source, destination} au graphe, en créant les
        sommets manquants le cas échéant."""
        max = max(source, destination)
        while max > self.nombre_sommets():
            self.ajouter_sommet()
        self._liste_adjacence[source].append(destination)
        self._liste_adjacence[destination].append(source)

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels."""
        for arete in iterable:
            self.ajouter_arete(arete[0], arete[1])

    def ajouter_sommet(self):
        """Ajoute un nouveau sommet au graphe et renvoie son identifiant.

        >>> G = ListeAdjacence()
        >>> G.ajouter_sommet()
        0
        >>> G._liste_adjacence
        [[]]
        >>> G.ajouter_sommet()
        1
        >>> G._liste_adjacence
        [[], []]
        """
        self._liste_adjacence.append([])
        return self.nombre_sommets() - 1

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u))."""
        ret = []
        for i in range(0, self.nombre_sommets()):
            for link in self._liste_adjacence[i]:
                if i != link:
                    ret.append([i, link])
        return ret


    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        ret = []
        for i in range(0, self.nombre_sommets()):
            for link in self._liste_adjacence[i]:
                if i == link:
                    ret.append([i, link])
        return ret

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        return v in self._liste_adjacence[u]

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u <= self.nombre_sommets()-1

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède."""
        return len(self._liste_adjacence[sommet])

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
        >>> ListeAdjacence(n).nombre_sommets() == n
        True
        """
        return len(self._liste_adjacence)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon."""
        if u < self.nombre_aretes() or v < self.nombre_aretes() or not (v in self._matrice_adjacence[u]) or not (u in self._matrice_adjacence[v]):
            raise Exception("Cette arête n'existe pas")
        self._matrice_adjacence[u].remove(v)
        self._matrice_adjacence[v].remove(u)

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for arete in iterable:
            self.retirer_arete(arete[0], arete[1])

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime."""
        pass  # à compléter

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
        return self._liste_adjacence[sommet]


def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
