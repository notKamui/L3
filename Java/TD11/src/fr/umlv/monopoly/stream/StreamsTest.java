package fr.umlv.monopoly.stream;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class StreamsTest {

	/**
	 * Renvoie une chaîne des caractères contenant les entiers de la liste séparés par
	 * des points virgules.
	 * Par exemple, listIntegerToString(List.of(5,6,7,9)) renvoie "5;6;7;9".
	 */
	public static String listIntegerToString(List<Integer> list){
		return list.stream().map(Object::toString).collect(Collectors.joining(";"));
	}

	/**
	 * Renvoie la somme de toutes les longueurs des chaînes de la liste.
	 * Par exemple, sumLength(List.of("ABC","DE","","F")) renvoie 6.
	 *
	 * Indication: la méthode sum n'est disponible que sur les streams
	 * de types primitifs IntStream, LongStream... Vous pouvez utiliser
	 * mapToInt pour créer un IntStream au lieu d'un Stream<Integer>
	 */

	public static int sumLength(List<String> list){
		return list.stream().mapToInt(String::length).sum();
	}

	/**
	 * Renvoie le nombre de chaînes non-vides du tableau
	 * Par exemple, String[] tab = {"ABC","DE","","F"};
	 *              countNonEmpty(tab) renvoie 3.
	 *
	 * Indication: Utilisez les méthodes Arrays.stream pour créer un stream à partir d'un tableau
	 */

	public static long countNonEmpty(String[] array){
		return Arrays.stream(array).filter(s -> !s.isEmpty()).count();
	}

	/**
	 * Renvoie la somme des entiers du tableau
	 * Par exemple, sumLength(Array.of(5,8,-1,2)) renvoie 14.
	 */

	public static long sum(int[] tab){
		return Arrays.stream(tab).sum();
	}

	/**
	 * Renvoie la liste des chaînes mises en majuscules
	 */
	public static List<String> capitalizeList(List<String> list){
		return list.stream().map(String::toUpperCase).collect(Collectors.toList());
	}

	/**
	 * Renvoie une map qui associe à chaque caractère la liste des chaînes commençant par ce caractère.
	 * Par exemple, mapByFirstCharacter(List.of("AB","A","BA","C") renvoie une map  qui associe
	 * au caractère 'A' la liste ["AB","A"], au caractère 'B' la liste ["BA"] et au caractère 'C' la liste ["C"]
	 *
	 * Indication : Utilisez Collectors.groupingBy
	 */
	public static Map<Character,List<String>> mapByFirstCharacter(List<String> list){
		return list.stream()
				.filter(s -> !s.isEmpty())
				.collect(Collectors.groupingBy(s -> s.charAt(0)));
	}

	/**
	 * Renvoie une map qui associe à chaque caractère l'ensemble des chaînes commençant par ce caractère.
	 * Par exemple, mapByFirstCharacterSet(List.of("AB","A","BA","C") renvoie une map  qui associe
	 * au caractère 'A' l'ensemble {"AB","A"}, au caractère 'B' l'ensemble {"BA"} et au caractère 'C' l'ensemble {"C"}
	 */
	public static Map<Character,Set<String>> mapByFirstCharacterSet(List<String> list){
		return list.stream()
				.filter(s -> !s.isEmpty())
				.collect(Collectors.groupingBy(
						s -> s.charAt(0), Collectors.mapping(s -> s, Collectors.toSet())
				));
	}

	/**
	 * Renvoie une map qui associe à chaque caractère le nombre de chaînes commençant par ce caractère.
	 * Par exemple, mapByFirstCharacterSet(List.of("AB","A","BA","C") renvoie une map qui associe
	 * au caractère 'A' la valeur 2, au caractère 'B' la valeur 1 et au caractère 'C' la valeur 1
	 */
	public static Map<Character, Long> countByFirstCharacter(List<String> list){
		return list.stream()
				.filter(s -> !s.isEmpty())
				.collect(Collectors.groupingBy(
						s -> s.charAt(0),
						Collectors.counting()
				));
	}

	/**
	 * Renvoie la liste de String privée de son premier élément.
	 * Indication : Utilisez Stream.skip
	 */

	public static List<String> withoutFirstElement(List<String> list){
		return list.stream().skip(1).collect(Collectors.toList());
	}

	/**
	 * Renvoie la liste de T privée de son premier élément.
	 * Maintenant cette méthode peut être appliquée à n'importe quel type de List
	 * List<Integer>,...
	 */

	public static <T> List<T> withoutFirstElementBetter(List<T> list){
		return list.stream().skip(1).collect(Collectors.toList());
	}

	/**
	 * Renvoie la liste des mots de la chaîne prise en argument.
	 * Par exemple, words("Abc def   i") renvoie ["Abc","def","i"]
	 * Indication : Utilisez String.split() et éliminez les chaînes vides
	 */

	public static List<String> words(String s){
		return Arrays.stream(s.split(" ")).filter(w -> !w.isEmpty()).collect(Collectors.toList());
	}

	/**
	 * Renvoie l'ensemble des mots apparaissant dans la liste prise en argument.
	 * Par example, words(List.of("Abc def i","def i","Abc de")) renvoie l'ensemble
	 * {"Abc","def","i","de"}
	 * Indication : Utilisez Stream.flatmap
	 */

	public static Set<String> words(List<String> list){
		return list.stream().flatMap(
				s -> Arrays.stream(s.split(" "))
		).collect(Collectors.toSet());
	}

	/**
	 * Renvoie l'ensemble des chaînes apparaissant dans la liste d'Optional<String> prise en argument.
	 * Par exemple, unpack(List.of(Optional.empty(),Optional.of("A"),Optional.of("B"),Optional.of("A"))) renvoie
	 * l'ensemble {"A","B"}
	 *
	 * Indication: les Optional peuvent être transformés en stream avec Optional.stream()
	 */

	public static Set<String> unpack(List<Optional<String>> list){
		return list.stream().flatMap(Optional::stream).collect(Collectors.toSet());
	}

	/**
	 * Renvoie une map comptant le nombre d'occurences de chaque caractère dans la chaîne.
	 * Par exemple, occurrences("ABBAAABBB") renvoie la map qui associe au caractère 'A' la valeur
	 * 4 et au caractère 'B' la valeur 5
	 *
	 * Indication: vous pouvez utiliser s.chars().mapToObj( c-> (char) c) obtenir un Stream<Character> à partir d'une chaîne
	 */

	public static Map<Character,Long> occurrences(String s){
		return Stream.of(s)
				.flatMap(str -> str.chars().mapToObj(c -> (char)c))
				.collect(Collectors.groupingBy(
						Function.identity(),
						Collectors.counting()
				));
	}

	public static void main(String[] args) {
		System.out.println(listIntegerToString(List.of(5,6,7,9)));
		System.out.println(sumLength(List.of("ABC","DE","","F")));
		String[] tab = {"ABC","DE","","F"};
		System.out.println(countNonEmpty(tab));
		int[] tab2 = {2,3};
		System.out.println(sum(tab2));
		System.out.println(capitalizeList(List.of("bonjour","aurevoir")));
		System.out.println(mapByFirstCharacter(List.of("AB","A","BA","C", "")));
		System.out.println(mapByFirstCharacterSet(List.of("AB","A","AB","BA","C", "")));
		System.out.println(countByFirstCharacter(List.of("AB","A","BA","C")));
		System.out.println(unpack(List.of(Optional.empty(),Optional.of("A"),Optional.of("B"),Optional.of("A"))));
		System.out.println(withoutFirstElement(List.of("A","B","C")));
		System.out.println(withoutFirstElementBetter(List.of(1,2,4)));
		System.out.println(words("Abc def   i"));
		System.out.println(words(List.of("Abc def i","def i","Abc de")));
		System.out.println(unpack(List.of(Optional.empty(),Optional.of("A"),Optional.of("B"),Optional.of("A"))));
		System.out.println(occurrences("AABBBAABB"));

	}
}