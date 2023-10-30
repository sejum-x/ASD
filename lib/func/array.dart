import 'dart:math';
import 'dart:core';

class SortingHelper {
  static List<int> generateRandomArray(int length, int max) {
    Random random = Random();
    List<int> array = List.generate(length, (index) => random.nextInt(max));
    return array;
  }

  static List<int> selectionSort(List<int> array) {
    int n = array.length;
    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < n; j++) {
        if (array[j] < array[minIndex]) {
          minIndex = j;
        }
      }
      if (minIndex != i) {
        int temp = array[i];
        array[i] = array[minIndex];
        array[minIndex] = temp;
      }
    }
    return array;
  }

  static List<int> shellSort(List<int> array) {
    int n = array.length;
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < n; i++) {
        int temp = array[i];
        int j;
        for (j = i; j >= gap && array[j - gap] > temp; j -= gap) {
          array[j] = array[j - gap];
        }
        array[j] = temp;
      }
    }
    return array;
  }

  static List<int> quickSort(List<int> array) {
    if (array.length <= 1) return array;

    int pivot = array[0];
    List<int> left = [];
    List<int> right = [];

    for (int i = 1; i < array.length; i++) {
      if (array[i] <= pivot) {
        left.add(array[i]);
      } else {
        right.add(array[i]);
      }
    }

    List<int> sortedLeft = quickSort(left);
    List<int> sortedRight = quickSort(right);

    return [...sortedLeft, pivot, ...sortedRight];
  }

  static double measureSortingTime(List<int> Function(List<int>) sortingAlgorithm, List<int> array) {
    final stopwatch = Stopwatch()..start();
    sortingAlgorithm(array);
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds / 1000;
  }

  static List<int> mergeSort(List<int> array) {
    if (array.length <= 1) {
      return array;
    }

    final int middle = array.length ~/ 2;
    final List<int> left = array.sublist(0, middle);
    final List<int> right = array.sublist(middle);

    return merge(mergeSort(left), mergeSort(right));
  }

  static List<int> merge(List<int> left, List<int> right) {
    List<int> result = [];
    int i = 0, j = 0;

    while (i < left.length && j < right.length) {
      if (left[i] < right[j]) {
        result.add(left[i]);
        i++;
      } else {
        result.add(right[j]);
        j++;
      }
    }

    result.addAll(left.sublist(i));
    result.addAll(right.sublist(j));

    return result;
  }

  static List<int> countingSort(List<int> array) {
    int max = array.reduce((value, element) => value > element ? value : element);
    int min = array.reduce((value, element) => value < element ? value : element);
    int range = max - min + 1;

    List<int> count = List.filled(range, 0);
    List<int> output = List.filled(array.length, 0);

    for (int i = 0; i < array.length; i++) {
      count[array[i] - min]++;
    }

    for (int i = 1; i < range; i++) {
      count[i] += count[i - 1];
    }

    for (int i = array.length - 1; i >= 0; i--) {
      output[count[array[i] - min] - 1] = array[i];
      count[array[i] - min]--;
    }

    for (int i = 0; i < array.length; i++) {
      array[i] = output[i];
    }

    return array;
  }
}