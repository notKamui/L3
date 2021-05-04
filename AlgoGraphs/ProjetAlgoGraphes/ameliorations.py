from graphe import *
import os.path
import math


def charger_donnees(graphe, fichier):
    """
    Ajoute au graphe donné les sommets et aretes définies par le fichier donné.
    Si le fichier n'existe pas, alors rien n'est effectué (outre un message d'erreur).
    """
    if not os.path.isfile(fichier):
        print("Ce fichier est introuvable")
        return

    with open(fichier) as f:
        content = f.read().splitlines()

    state = 0
    graphe_name = fichier.rsplit('.', 1)[0]
    for line in content:
        if line.startswith('#'):
            if line == "# connexions":
                state = 1
        elif state == 0:
            data = line.split(':')
            graphe.ajouter_sommet(int(data[0]), data[1])
        else:
            data = line.split('/')
            graphe.ajouter_arete(int(data[0]), int(data[1]), graphe_name)


def numerotation(reseau):
    """
    Retourne les différents dictionnaire qui représente un parcours orienté du réseau donné
    """
    debut, parent, ancetre = dict(), dict(), dict()
    instant = 0
    for s in reseau.sommets():
        debut[s] = 0
        parent[s] = None
        ancetre[s] = math.inf

    def numerotation_rec(s):
        nonlocal instant
        instant += 1
        debut[s] = ancetre[s] = instant
        for t in reseau.voisins(s):
            if debut[t] != 0:
                if parent[s] != t:
                    ancetre[s] = min(ancetre[s], debut[t])
            else:
                parent[t] = s
                numerotation_rec(t)
                ancetre[s] = min(ancetre[s], ancetre[t])

    for v in reseau.sommets():
        if debut[v] == 0:
            numerotation_rec(v)

    return debut, parent, ancetre


def points_articulation(reseau):
    """
    Retourne l'ensemble des points d'articulations du reseau donné.
    Un point est un sommet.
    """
    debut, parent, ancetre = numerotation(reseau)
    articulations = set()

    racines = set(filter(lambda x: parent[x] is None, reseau.sommets()))
    for depart in racines:
        if sum(v == depart for v in parent.values()) >= 2:
            articulations.add(depart)

    racines.add(None)
    for v in reseau.sommets():
        if parent[v] not in racines and ancetre[v] >= debut[parent[v]]:
            articulations.add(parent[v])

    return articulations


def ponts(reseau):
    """
    Retourne l'ensemble des ponts du reseau donné.
    Un pont une pair de sommets (une arete).
    """
    debut, parent, ancetre = numerotation(reseau)
    ret = set()
    for v in reseau.sommets():
        u = parent[v]
        if u is not None and ancetre[v] > debut[u]:
            ret.add((u, v))
    return ret


def amelioration_ponts(reseau):
    """
    Retourne un ensemble d'aretes possible pour supprimer les ponts du reseau donné
    """
    ponts_set = ponts(reseau)
    pivots = list(set(sum(ponts_set, ())))
    csp_lst = list()

    def scan_csp_feuille(depart, csp, skip):
        """
        Retourne True si le CSP trouvé est une feuille, False sinon (peut donc être ignoré).
        Un CSP est un set de sommets.
        skip représent un itérable de sommets à éviter (notament le pont de départ)
        """
        csp.add(depart)
        for v in reseau.voisins(depart):
            if v not in skip and v not in csp and (v in pivots or not scan_csp_feuille(v, csp, skip)):
                return False
        return True

    # Pour chaque pont, scanner les csp autour et les ajouter à la csp_list si ce sont des feuilles
    for (u, v) in ponts_set:
        skip = [u, v]
        csp = set()
        if scan_csp_feuille(u, csp, skip):
            csp_lst.append(csp)
        csp = set()
        if scan_csp_feuille(v, csp, skip):
            csp_lst.append(csp)

    def take_rand(csp):
        """
        Prend un sommet aléatoire du csp qui n'est pas l'extrémité d'un pont,
        sauf si c'est le seul sommet disponible, en quel cas il est renvoyé.
        """
        if len(csp) > 1:
            csp = filter(lambda s: s not in pivots, csp)
        return next(iter(csp))

    # liste des sommets choisis aléatoirement de chaque csp
    it = list(map(lambda csp: take_rand(csp), csp_lst))
    # pairage non cyclique deux à deux de ces sommets
    return set(list(zip(it, it[1:] + it[:1]))[:-1])


def amelioration_points_articulation(reseau):
    pass
