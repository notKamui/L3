class Graphe(object):
    def __init__(self):
        """Initialise un graphe sans arêtes"""
        self.dictionnaire = dict()

    def ajouter_arete(self, u, v, poids):
        """Ajoute une arête entre les sommmets u et v, en créant les sommets
        manquants le cas échéant."""
        # vérification de l'existence de u et v, et création(s) sinon
        if u not in self.dictionnaire:
            self.dictionnaire[u] = set()
        if v not in self.dictionnaire:
            self.dictionnaire[v] = set()
        # ajout de u (resp. v) parmi les voisins de v (resp. u)
        self.dictionnaire[u].add((v, poids))
        self.dictionnaire[v].add((u, poids))

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v, poids in iterable:
            self.ajouter_arete(u, v, poids)

    def ajouter_sommet(self, sommet):
        """Ajoute un sommet (de n'importe quel type hashable) au graphe."""
        self.dictionnaire[sommet] = set()

    def ajouter_sommets(self, iterable):
        """Ajoute tous les sommets de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des éléments hashables."""
        for sommet in iterable:
            self.ajouter_sommet(sommet)

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe. Une arête est représentée
        par un tuple (a, b) avec a <= b afin de permettre le renvoi de boucles.
        """
        return {
            tuple((u, v, poids)) for u in self.dictionnaire
            for (v, poids) in self.dictionnaire[u]
            if u <= v
        }

    def poids_arete(self, u, v):
        return next(poids for (vt, poids) in self.dictionnaire[u] if vt == v)

    def boucles(self):
        """Renvoie les boucles du graphe, c'est-à-dire les arêtes reliant un
        sommet à lui-même."""
        return {(u, u) for u in self.dictionnaire if u in self.dictionnaire[u]}

    def contient_arete(self, u, v):
        """Renvoie True si l'arête {u, v} existe, False sinon."""
        if self.contient_sommet(u) and self.contient_sommet(v):
            return u in self.dictionnaire[v]  # ou v in self.dictionnaire[u]
        return False

    def contient_sommet(self, u):
        """Renvoie True si le sommet u existe, False sinon."""
        return u in self.dictionnaire

    def degre(self, sommet):
        """Renvoie le nombre de voisins du sommet; s'il n'existe pas, provoque
        une erreur."""
        return len(self.dictionnaire[sommet])

    def nombre_aretes(self):
        """Renvoie le nombre d'arêtes du graphe."""
        return len(self.aretes())

    def nombre_boucles(self):
        """Renvoie le nombre d'arêtes de la forme {u, u}."""
        return len(self.boucles())

    def nombre_sommets(self):
        """Renvoie le nombre de sommets du graphe."""
        return len(self.dictionnaire)

    def retirer_arete(self, u, v):
        """Retire l'arête {u, v} si elle existe; provoque une erreur sinon."""
        self.dictionnaire[u].remove(v)  # plante si u ou v n'existe pas
        self.dictionnaire[v].remove(u)  # plante si u ou v n'existe pas

    def retirer_aretes(self, iterable):
        """Retire toutes les arêtes de l'itérable donné du graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v in iterable:
            self.retirer_arete(u, v)

    def retirer_sommet(self, sommet):
        """Efface le sommet du graphe, et retire toutes les arêtes qui lui
        sont incidentes."""
        del self.dictionnaire[sommet]
        # retirer le sommet des ensembles de voisins
        for u in self.dictionnaire:
            self.dictionnaire[u].discard(sommet)

    def retirer_sommets(self, iterable):
        """Efface les sommets de l'itérable donné du graphe, et retire toutes
        les arêtes incidentes à ces sommets."""
        for sommet in iterable:
            self.retirer_sommet(sommet)

    def sommets(self):
        """Renvoie l'ensemble des sommets du graphe."""
        return set(self.dictionnaire.keys())

    def sous_graphe_induit(self, iterable):
        """Renvoie le sous-graphe induit par l'itérable de sommets donné."""
        G = Graphe()
        G.ajouter_sommets(iterable)
        for u, v in self.aretes():
            if G.contient_sommet(u) and G.contient_sommet(v):
                G.ajouter_arete(u, v)
        return G

    def voisins(self, sommet):
        """Renvoie l'ensemble des voisins du sommet donné."""
        return self.dictionnaire[sommet]


class Tas(object):
    """Implémentation de la structure de données Tas."""
    class Node(object):
        def __init__(self, value):
            self.value = value
            self.left = None
            self.right = None

    def __init__(self):
        """Initialisation des structures de données nécessaires."""
        self.root = None

    def _rec_insert(self, node, value):
        if node is None:
            return self.Node(value)
        else:
            if value <= node.value:
                node.left = self._rec_insert(node.left, value)
            else:
                node.right = self._rec_insert(node.right, value)
        return node

    def inserer(self, element):
        """Insère un élément dans le tas en préservant la structure."""
        if (self.root is None):
            self.root = self.Node(element)
        else:
            self._rec_insert(self.root, element)

    def _rec_remove_min(self, node):
        if node.left.left is None:
            min_node = node.left
            node.left = node.left.right
            min_node.right = None
            return min_node
        else:
            return self._rec_remove_min(node.left)

    def extraire_minimum(self):
        """Extrait et renvoie le minimum du tas en préservant sa structure."""
        if self.root is None:
            return None
        elif self.root.left is not None:
            return self._rec_remove_min(self.root).value
        else:
            min_node = self.root
            self.root = self.root.right
            min_node.right = None
            return min_node.value

    def est_vide(self):
        return self.root is None


class UnionFind(object):
    """Implémentation de la structure de données Union-Find."""

    def __init__(self, ensemble):
        """Initialisation des structures de données nécessaires."""
        self.root = dict()
        for e in ensemble:
            self.root[e] = e

    def find(self, element):
        """Renvoie le numéro de la classe à laquelle appartient l'élément."""
        while element != self.root[element]:
            element = self.root[element]
        return element

    def union(self, premier, second):
        """Fusionne les classes contenant les deux éléments donnés."""
        rootA = self.find(premier)
        rootB = self.find(second)
        if rootA != rootB:
            self.root[rootA] = rootB


def stocker_arete_valide(G, u, S, hors_arbre):
    for (v, p) in G.voisins(u):
        if hors_arbre[v]:
            S.inserer((p, u, v))


def extraire_arete_sure(S, hors_arbre):
    while not S.est_vide():
        (p, u, v) = S.extraire_minimum()
        if hors_arbre[u] != hors_arbre[v]:
            return (u, v, p)
    return (None, None, -1)


def acpm_prim(G, depart):
    A = type(G)()
    A.ajouter_sommet(depart)
    hors_arbre = {}
    for s in G.sommets():
        hors_arbre[s] = True
    hors_arbre[depart] = False
    candidates = Tas()
    stocker_arete_valide(G, depart, candidates, hors_arbre)
    while A.nombre_aretes() < G.nombre_sommets() - 1:
        (u, v, p) = extraire_arete_sure(candidates, hors_arbre)
        if u is None:
            return A
        if not hors_arbre[u]:
            u, v = v, u
        A.ajouter_arete(u, v, p)
        hors_arbre[u] = False
        stocker_arete_valide(G, u, candidates, hors_arbre)
    return A


def fcpm_prim(G):
    F = type(G)()
    S = list(G.sommets())
    while len(S) > 0:
        A = acpm_prim(G, S[0])
        F.ajouter_aretes(A.aretes())
        S = list(set(S) - A.sommets())
    return F


def acpm_kruskal(G):
    F = type(G)()
    C = UnionFind(G.sommets())
    for (u, v, p) in sorted(G.aretes(), key=lambda tup: tup[2]):
        if C.find(u) != C.find(v):
            F.ajouter_arete(u, v, p)
            C.union(C.find(u), C.find(v))
    return F
