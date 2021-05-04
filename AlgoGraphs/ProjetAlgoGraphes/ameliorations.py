from graphe import *
import os.path
import math


def charger_donnees(graphe, fichier):
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
    debut = dict()
    parent = dict()
    ancetre = dict()
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
    debut, parent, ancetre = numerotation(reseau)
    ret = set()
    for u in reseau.sommets():
        v = parent[u]
        if v is not None and ancetre[u] > debut[v]:
            ret.add((u, v))
    return ret


def amelioration_ponts(reseau):
    ponts_ = ponts(reseau)
    pivots = list(set(sum(ponts_, ())))
    csp_lst = list()

    def trouver_csp(depart, csp):
        csp.add(depart)
        for v in reseau.voisins(depart):
            if v not in evite and v not in csp and (v in pivots or not trouver_csp(v, csp)):
                return False
        return True

    for (u, v) in ponts_:
        evite = [u, v]
        csp = set()
        if trouver_csp(u, csp):
            csp_lst.append(csp)
        csp = set()
        if trouver_csp(v, csp):
            csp_lst.append(csp)

    def take_rand(csp):
        if len(csp) > 1:
            csp = filter(lambda s: s not in pivots, csp)
        return next(iter(csp))

    tmp = list(map(lambda csp: take_rand(csp), csp_lst))
    return set(zip(tmp, tmp[1:] + tmp[:1]))


def amelioration_points_articulation(reseau):
    pass
