class Graphe(object):
    def __init__(self):
        """Initialise un graphe sans arêtes"""
        self.dictionnaire = dict()
        self.noms = dict()

    def ajouter_arete(self, u, v, nom):
        """Ajoute une arête entre les sommmets u et v, en créant les sommets
        manquants le cas échéant."""
        # vérification de l'existence de u et v, et création(s) sinon
        if u not in self.dictionnaire:
            self.dictionnaire[u] = set()
        if v not in self.dictionnaire:
            self.dictionnaire[v] = set()
        # ajout de u (resp. v) parmi les voisins de v (resp. u)
        self.dictionnaire[u].add((v, nom))
        self.dictionnaire[v].add((u, nom))

    def ajouter_aretes(self, iterable):
        """Ajoute toutes les arêtes de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des couples d'éléments (quel que soit le type du couple)."""
        for u, v, nom in iterable:
            self.ajouter_arete(u, v, nom)

    def ajouter_sommet(self, sommet, nom):
        """Ajoute un sommet (de n'importe quel type hashable) au graphe."""
        self.dictionnaire[sommet] = set()
        self.noms[sommet] = nom

    def ajouter_sommets(self, iterable):
        """Ajoute tous les sommets de l'itérable donné au graphe. N'importe
        quel type d'itérable est acceptable, mais il faut qu'il ne contienne
        que des éléments hashables."""
        for (sommet, nom) in iterable:
            self.ajouter_sommet(sommet, nom)

    def aretes(self):
        """Renvoie l'ensemble des arêtes du graphe. Une arête est représentée
        par un tuple (a, b) avec a <= b afin de permettre le renvoi de boucles.
        """
        return {
            tuple((u, v, nom)) for u in self.dictionnaire
            for (v, nom) in self.dictionnaire[u]
            if u <= v
        }

    def nom_arete(self, u, v):
        return next(nom for (vt, nom) in self.dictionnaire[u] if vt == v)

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

    def nom_sommet(self, id):
        return self.noms[id]

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
        return {v for v, _ in self.dictionnaire[sommet]}
