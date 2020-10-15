#!/bin/kscript

fun ua(n: Int): Int = when(n) {
    0 -> 2
    1 -> 1
    else -> ua(n-1) + ua(n-2)
}

fun ub(n: Int): Int = when(n) {
    0 -> 1
    1 -> 1
    2 -> 2
    else -> ub(n-1) + ub(n-2) - ub(n-3)
}

fun uc(n: Int): Int = when(n) {
    0 -> 1
    1 -> 1
    else -> 2*uc(n-1) - uc(n-2) + n-1
}

val cached = mutableMapOf(0 to 1)
fun ud(n: Int): Int = when {
    cached.containsKey(n) -> cached[n]!!
    else -> {
        cached[n] = (0..n-1).sumBy { i -> ud(i) * ud(n-1-i) }
        cached[n]!!
    }
}

/*fun ue(n: Int): Int = when(n) {
    0 -> 1
    1 -> 1
    else -> ue(n-1) + (0..n-1).sumBy { i -> ue(i) + ue(n-2-i) }
}*/

(0..6).forEach { print("${ua(it)} ") }
println()
(0..6).forEach { print("${ub(it)} ") }
println()
(0..6).forEach { print("${uc(it)} ") }
println()
(0..6).forEach { print("${ud(it)} ") }
println()
/*(0..6).forEach { print("${ue(it)} ") }
println()*/