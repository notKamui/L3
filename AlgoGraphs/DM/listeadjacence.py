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
        sommets manquants le cas échéant.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_arete(0,1)
        >>> G.ajouter_arete(1,2)
        >>> G._liste_adjacence
        [[1], [0, 2], [1]]
        """
        _max = max(source, destination)+1
        while _max > self.nombre_sommets():
            self.ajouter_sommet()
        if (destination in self._liste_adjacence[source]) or (source in self._liste_adjacence[destination]):
            return
        self._liste_adjacence[source].append(destination)
        if destination != source:
            self._liste_adjacence[destination].append(source)

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples de naturels.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,1], [1, 2]])
        >>> G._liste_adjacence
        [[1], [0, 2], [1]]
        """
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
        c'est-à-dire les arêtes de la forme (u, u)).
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.aretes()
        {(1, 2), (1, 3)}
        """
        ret = set()
        for i in range(0, self.nombre_sommets()):
            for link in self._liste_adjacence[i]:
                if i != link and not ((link, i) in ret):
                    ret.add((i, link))
        return ret


    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.boucles()
        {(1, 1), (0, 0)}
        """
        ret = set()
        for i in range(self.nombre_sommets()):
            for link in self._liste_adjacence[i]:
                if i == link:
                    ret.add((i, link))
        return ret

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.contient_arete(2, 1)
        True
        >>> G.contient_arete(5, 5)
        False
        >>> G.contient_arete(1, 0)
        False
        """
        try:
            return v in self._liste_adjacence[u]
        except IndexError:
            return False

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.contient_sommet(2)
        True
        >>> G.contient_sommet(5)
        False
        """
        return u < self.nombre_sommets()

    def degre(self, sommet):
        """Renvoie le degré d'un sommet, c'est-à-dire le nombre de voisins
        qu'il possède.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.degre(2)
        1
        >>> G.degre(5)
        0
        """
        try:
            return len(self._liste_adjacence[sommet])
        except IndexError:
            return 0

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe.

        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.nombre_aretes()
        2
        """
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.nombre_boucles()
        2
        """
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
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G._liste_adjacence
        [[0], [2, 3, 1], [1], [1]]
        >>> G.retirer_arete(2, 1)
        >>> G._liste_adjacence
        [[0], [3, 1], [], [1]]
        >>> G.retirer_arete(5, 5)
        Traceback (most recent call last):
        AssertionError: Cette arête n'existe pas
        """
        assert self.contient_arete(u, v), "Cette arête n'existe pas"
        self._liste_adjacence[u].remove(v)
        if u != v:
            self._liste_adjacence[v].remove(u)

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple).
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.retirer_aretes([[2,1], [0, 0]])
        >>> G._liste_adjacence
        [[], [3, 1], [], [1]]
        """
        for arete in iterable:
            self.retirer_arete(arete[0], arete[1])

    def retirer_sommet(self, sommet):
        """Déconnecte un sommet du graphe et le supprime.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G._liste_adjacence
        [[0], [2, 3, 1], [1], [1]]
        >>> G.retirer_sommet(0)
        >>> G._liste_adjacence
        [[1, 2, 0], [0], [0]]
        """
        assert self.contient_sommet(sommet), "Ce sommet n'existe pas"
        to_del = []
        for u in self.sommets():
            if u != sommet:
                for i in range(self.degre(u)):
                    v = self._liste_adjacence[u][i]
                    if v > sommet:
                        self._liste_adjacence[u][i] -= 1
                    elif v == sommet:
                        to_del.append((u, v))
        self.retirer_aretes(to_del)
        self._liste_adjacence.pop(sommet)


    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G._liste_adjacence
        [[0], [2, 3, 1], [1], [1]]
        >>> G.retirer_sommets([0, 2])
        >>> G._liste_adjacence
        [[1, 0], [0]]
        """
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 3]])
        >>> G._liste_adjacence
        [[0], [2], [1], [3]]
        >>> G.sommets()
        {0, 1, 2, 3}
        """
        return set(range(self.nombre_sommets()))

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        sommets = iterable.copy()
        sommets.sort()
        sub = ListeAdjacence(len(sommets))
        for i in range(len(sommets)):
            u = sommets[i]
            assert self.contient_sommet(u), "Ce sommet n'existe pas"
            for j in range(i + 1):
                v = sommets[j]
                if self.contient_arete(u, v):
                    sub.ajouter_arete(i, j)
        return sub

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet.
        
        >>> G = ListeAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G._liste_adjacence
        [[0], [2, 3, 1], [1], [1]]
        >>> G.voisins(1)
        [2, 3, 1]
        """
        assert self.contient_sommet(sommet), "Ce sommet n'existe pas"
        return self._liste_adjacence[sommet]

def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
