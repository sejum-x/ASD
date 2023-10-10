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
}