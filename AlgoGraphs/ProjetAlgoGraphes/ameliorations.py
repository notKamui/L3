from graphe import *
import os.path
import math
import argparse


def charger_donnees(graphe, fichier):
    """
    Ajoute au graphe donné les sommets et aretes définies par le fichier donné.
    Si le fichier n'existe pas, alors rien n'est effectué (outre un message d'erreur).
    """
    if not os.path.isfile(fichier):
        print("Le fichier " + fichier + " est introuvable. Il est ignoré.")
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
    Retourne un ensemble d'aretes possible pour supprimer les ponts du réseau donné
    """
    ponts_set = ponts(reseau)
    if len(ponts_set) == 0:
        return set()
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
        for s in skip:
            csp = set()
            if scan_csp_feuille(s, csp, skip):
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
    """
    Retourne un ensemble d'arete possible pour supprimer les points d'articulation du réseau donné
    """
    debut, parent, ancetre = numerotation(reseau)
    articulations = list(sorted(
        points_articulation(reseau),
        key=lambda it: debut[it],
        reverse=True
    ))
    if len(articulations) == 0:
        return set()
    racine = next(filter(lambda s: debut[s] == 1, reseau.sommets()))
    ret = set()
    fils = list()

    # check si la dernière articulation est la racine, et la retire si c'est le cas
    flag_racine = False
    if articulations[-1] == racine:
        flag_racine = True
        articulations.pop()

    # check des cycles des articulations et ajout des aretes vers la racin
    for v in reseau.sommets():
        if v not in articulations and parent[v] in articulations and ancetre[v] >= debut[parent[v]]:
            ret.add((racine, v))

    if flag_racine:
        # ajoute à fils chaque fils de racine
        for u in reseau.sommets():
            if parent[u] == racine:
                fils.append(u)

    # ajoute au set final les paires deux à deux des fils de la racine
    if len(fils) >= 2:
        ret.update(list(zip(fils, fils[1:] + fils[:1]))[:-1])

    return ret


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Analyse et améliore les réseaux ferrés de Paris"
    )
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument(
        "--metro",
        help="analyse les lignes de Métro",
        nargs="*"
    )
    group.add_argument(
        "--rer",
        help="analyse les lignes RER",
        nargs="*"
    )
    parser.add_argument(
        "-l",
        "--liste-stations",
        help="affiche la liste des stations du réseau",
        action="store_true"
    )
    parser.add_argument(
        "-a",
        "--articulations",
        help="affiche les points d'articulation du réseau",
        action="store_true"
    )
    parser.add_argument(
        "-p",
        "--ponts",
        help="affiche les ponts du réseau",
        action="store_true"
    )
    parser.add_argument(
        "-A",
        "--ameliorer-articulations",
        help="idem que -a, en plus d'afficher les arêtes à ajouter pour que ces stations ne soient plus des points d'articulation",
        action="store_true"
    )
    parser.add_argument(
        "-P",
        "--ameliorer-ponts",
        help="idem que -p, en plus d'afficher les arêtes à ajouter pour que ces ponts n'en soient plus",
        action="store_true"
    )

    args = parser.parse_args()

    if args.rer is not None:
        lines = args.rer
        prefix = "RER"
    else:
        lines = args.metro
        prefix = "METRO"

    if len(lines) == 0:
        files = [file for file in os.listdir('.') if file.startswith(prefix)]
        print("Chargement des lignes de {1}...".format(
            lines, prefix.lower()))
    else:
        files = list(map(lambda file: prefix + "_" + file + ".txt", lines))
        print("Chargement des lignes {0} de {1}...".format(
            lines, prefix.lower()))

    reseau = Graphe()
    for file in files:
        charger_donnees(reseau, file)

    print("Terminé !")

    print("Le réseau contient {0} sommet(s) et {1} arête(s).".format(
        len(reseau.sommets()), len(reseau.aretes())))

    print()

    if args.liste_stations:
        print("Le réseau contient les stations suivantes:")
        for s in sorted(reseau.sommets(), key=reseau.nom_sommet):
            print("{0} ({1})".format(reseau.nom_sommet(s), s))
        print()

    if args.ponts or args.ameliorer_ponts:
        ponts_ = ponts(reseau)
        if len(ponts_) > 0:
            print("Le réseau contient le(s) {0} pont(s) suivant(s)".format(
                len(ponts_)
            ))
            fm = sorted(list(map(
                lambda p: "{0} -- {1}".format(
                    reseau.nom_sommet(p[0]), reseau.nom_sommet(p[1])
                ),
                ponts_
            )))
            for p in fm:
                print("\t{0}".format(p))
        else:
            print("Le réseau ne contient aucun pont.")

        print()
        if args.ameliorer_ponts and len(ponts_) > 0:
            aretes = amelioration_ponts(reseau)
            print("On peut éliminer tout les ponts du réseau en rajoutant les {0} arête(s) suivante(s):".format(
                len(aretes)
            ))
            fm = sorted(list(map(
                lambda p: "{0} -- {1}".format(
                    reseau.nom_sommet(p[0]), reseau.nom_sommet(p[1])
                ),
                aretes
            )))
            for p in fm:
                print("\t{0}".format(p))
        print()

    if args.articulations or args.ameliorer_articulations:
        articulations = points_articulation(reseau)
        if len(articulations) > 0:
            print("Le réseau contient le(s) {0} point(s) d'articulation suivant(s)".format(
                len(articulations)
            ))
            fm = sorted(list(map(reseau.nom_sommet, articulations)))
            for i, s in enumerate(fm, start=1):
                print("\t{0} : {1}".format(i, s))
        else:
            print("Le réseau ne contient aucun point d'articulation")

        print()
        if args.ameliorer_articulations and len(articulations) > 0:
            aretes = amelioration_points_articulation(reseau)
            print("On peut éliminer tout les points d'articulation du réseau en rajoutant les {0} arête(s) suivante(s):".format(
                len(aretes)
            ))
            fm = sorted(list(map(
                lambda p: "{0} -- {1}".format(
                    reseau.nom_sommet(p[0]), reseau.nom_sommet(p[1])
                ),
                aretes
            )))
            for p in fm:
                print("\t{0}".format(p))
        print()
