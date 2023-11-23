import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: BinarySearchPage(),
  ));
}

class BinarySearchPage extends StatefulWidget {
  const BinarySearchPage({Key? key}) : super(key: key);

  @override
  State<BinarySearchPage> createState() => _BinarySearchPageState();
}

class _BinarySearchPageState extends State<BinarySearchPage>{
  final ArrayManager arrayManager = ArrayManager();
  final TextEditingController sizeControllerA = TextEditingController();
  final TextEditingController sizeControllerB = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  List<int> arrayA = [];
  List<int> arrayB = [];
  List<int> arrayC = [];
  int Element = -1;
  int searchedElement = -1;
  int comparisons = 0;

  @override
  void dispose() {
    sizeControllerA.dispose();
    sizeControllerB.dispose();
    maxController.dispose();
    super.dispose();
  }

  void generateArrays() {
    int sizeA = int.tryParse(sizeControllerA.text) ?? 0;
    int sizeB = int.tryParse(sizeControllerB.text) ?? 0;
    int max = int.tryParse(maxController.text) ?? 100;

    arrayA = arrayManager.generateArray(sizeA, max: max);
    arrayB = arrayManager.generateArray(sizeB, max: max);
    arrayC = arrayManager.getCArray(arrayA, arrayB);
    Element = arrayManager.findElement(arrayC);
    searchedElement = arrayManager.binarySearch(arrayC, Element);
    comparisons = arrayManager.getComparisons();

    setState(() {}); // Оновлюємо інтерфейс після генерації масивів
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xffc6c3c1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: sizeControllerA,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter size for Array A', border: OutlineInputBorder(),),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: sizeControllerB,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter size for Array B', border: OutlineInputBorder(),),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter maximum value', border: OutlineInputBorder(),),
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: generateArrays,
              child: const Text('Generate Arrays'),
            ),
            SizedBox(height: 12.0),
            const SizedBox(height: 20),
            Text('Array C: $arrayC'),
            const SizedBox(height: 10),
            Text('Searched Element: $Element'),
            const SizedBox(height: 10),
            Text('Element index: $searchedElement'),
            const SizedBox(height: 10),
            Text('Comparisons: $comparisons'),
          ],
        ),
      ),
    );
  }
}

class ArrayManager {
  int comparisons = 0;

  List<int> generateArray(int length, {int max = 100}) {
    Random random = Random();
    return List.generate(length, (_) => random.nextInt(max + 1));
  }

  List<int> getCArray(List<int> arrayA, List<int> arrayB) {
    List<int> cArray = [];

    for (int i = 0; i < arrayA.length; i++) {
      if (arrayA[i] % 2 == 0) {
        cArray.add(arrayA[i]);
      }
    }

    for (int i = 0; i < arrayB.length; i++) {
      if (arrayB[i] % 2 != 0) {
        cArray.add(arrayB[i]);
      }
    }

    cArray.sort();
    return cArray;
  }

  int findElement(List<int> cArray) {
    if (cArray.isEmpty) {
      throw Exception("The array is empty");
    }

    int maxElement = cArray.last;
    int result = -1;

    for (int i = cArray.length - 2; i >= 0; i--) {
      if (cArray[i] < maxElement && cArray[i] % 5 == 2) {
        result = cArray[i];
        break;
      }
    }
    return result;
  }

  int binarySearch(List<int> array, int target) {
    comparisons = 0;
    int left = 0;
    int right = array.length - 1;
    while (left <= right) {
      int mid = left + ((right - left) ~/ 2);
      comparisons++;

      if (array[mid] == target) {
        return mid;
      } else if (array[mid] < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    return -1;
  }

  int getComparisons() {
    return comparisons;
  }
}
