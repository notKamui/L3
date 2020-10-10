import java.util.Arrays;

public abstract class Sort {
    public static void main(String[] args) {
        int[] array = { 2, 9, 5, 8, 3, 1 };
        System.out.println(Arrays.toString(array));
        sort(array);
        System.out.println(Arrays.toString(array));

    }

    /**
     * Swaps two values at given indices in a given array
     *
     * @param array the array
     * @param index1 the first index
     * @param index2 the second index
     */
    public static void swap(int[] array, int index1, int index2) {
        int temp = array[index1];
        array[index1] = array[index2];
        array[index2] = temp;
    }

    /**
     * Gives the index of the minimum value in a given array between two indices
     *
     * @param array the array. Length must be at least 1
     * @param index1 the first index. Must be inferior or equal to index2
     * @param index2 the second index. Must be greater or equal to index1
     * @return the index of the minimum value in the array between two indices
     */
    public static int indexOfMin(int[] array, int index1, int index2) {
        if (array.length < 1) throw new IllegalArgumentException("array.length must be at least 1");
        if (index1 > index2) throw new IllegalArgumentException("index2 should be greater or equal to index1");

        int min = Integer.MAX_VALUE;
        int minIndex = -1;
        for (int i = index1; i <= index2; i++) {
            if (min > array[i]) {
                min = array[i];
                minIndex = i;
            }
        }

        return minIndex;
    }

    /**
     * Gives the index of the minimum value in a given array
     *
     * @param array the array. Length must be at least 1
     * @return the index of the minimum value in the array
     */
    public static int indexOfMin(int[] array) {
        return indexOfMin(array, 0, array.length-1);
    }

    /**
     * Sorts the given array (ascending order)
     *
     * @param array the array to be sorted
     */
    public static void sort(int[] array) {
        for (int i = 0; i < array.length; i++) {
            swap(
                    array,
                    i,
                    indexOfMin(array, i, array.length-1)
            );
        }
    }
}
