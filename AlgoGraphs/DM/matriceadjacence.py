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
        _max = max(source, destination)+1
        while _max > self.nombre_sommets():
            self.ajouter_sommet()
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
        self._matrice_adjacence.append([0] * len(self._matrice_adjacence))
        for i in range(len(self._matrice_adjacence)):
            self._matrice_adjacence[i].append(0)
        return len(self._matrice_adjacence) - 1

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe sous forme de couples (si on
        les stocke sous forme de paires, on ne peut pas stocker les boucles,
        c'est-à-dire les arêtes de la forme (u, u)).
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.aretes()
        {(1, 2), (1, 3)}
        """
        ret = set()
        for i in range(len(self._matrice_adjacence)):
            for j in range(len(self._matrice_adjacence)):
                if self._matrice_adjacence[i][j] == 1 and j > i:
                    ret.add((i, j))
        return ret

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même.
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.boucles()
        {(1, 1), (0, 0)}
        """
        ret = set()
        for i in range(len(self._matrice_adjacence)):
            if self._matrice_adjacence[i][i] == 1:
                ret.add((i, i))
        return ret

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon.
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.contient_arete(2, 1)
        True
        >>> G.contient_arete(5, 5)
        False
        >>> G.contient_arete(1, 0)
        False
        """
        try:
            return self._matrice_adjacence[u][v] == 1
        except IndexError:
            return False

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon.
        
        >>> G = MatriceAdjacence()
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
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.degre(2)
        1
        >>> G.degre(5)
        0
        """
        if not self.contient_sommet(sommet):
            return 0
        return sum(self._matrice_adjacence[sommet])

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe.
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.nombre_aretes()
        2
        """
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}.
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G.nombre_boucles()
        2
        """
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
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon.
        
        >>> G = MatriceAdjacence()
        >>> G.ajouter_aretes([[0,0], [1, 2], [3, 1], [1, 1]])
        >>> G._matrice_adjacence
        [[1, 0, 0, 0], [0, 1, 1, 1], [0, 1, 0, 0], [0, 1, 0, 0]]
        >>> G.retirer_arete(2, 1)
        >>> G._matrice_adjacence
        [[1, 0, 0, 0], [0, 1, 0, 1], [0, 0, 0, 0], [0, 1, 0, 0]]
        >>> G.retirer_arete(5, 5)
        Traceback (most recent call last):
        AssertionError: Cette arête n'existe pas
        """
        assert self.contient_arete(u, v), "Cette arête n'existe pas"
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
        assert self.contient_sommet(sommet), "Ce sommet n'existe pas"
        del self._matrice_adjacence[sommet]
        for i in self._matrice_adjacence:
            del i[sommet]
        

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        return set(range(self.nombre_sommets()))

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        sommets = iterable.copy()
        sommets.sort()
        sub = MatriceAdjacence(len(sommets))
        for i in range(len(sommets)):
            u = sommets[i]
            assert self.contient_sommet(u), "Ce sommet n'existe pas"
            for j in range(i + 1):
                v = sommets[j]
                if self.contient_arete(u, v):
                    sub.ajouter_arete(i, j)
        return sub

    def voisins(self, sommet):
        """Renvoie la liste des voisins d'un sommet."""
        tmp = self._matrice_adjacence[sommet]
        ret = []
        for i in range(0, self.nombre_sommets()):
            if tmp[i] == 1:
                ret.append(i)
        return ret


def export_dot(graphe):
    """Renvoie une chaîne encodant le graphe au format dot.
    
    >>> G = MatriceAdjacence()
    >>> G.ajouter_aretes([[0,0], [1,2], [3,1], [2,2]])

    >>> export_dot(G)
    'graph {\\n0;\\n1;\\n2;\\n3;\\n0 -- 0;\\n1 -- 2;\\n1 -- 3;\\n2 -- 2;\\n}'
    """
    dot = "graph {\n"
    dot += ''.join([str(i) + ";\n" for i in graphe.sommets()])
    dot += ''.join([str(a[0]) + " -- " + str(a[1]) + ";\n" for a in graphe.aretes().union(graphe.boucles())])
    dot += '}'
    return dot


def main():
    import doctest
    doctest.testmod()


if __name__ == "__main__":
    main()
