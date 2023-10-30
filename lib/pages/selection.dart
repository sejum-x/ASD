/*import 'package:flutter/material.dart';

class Selection extends StatefulWidget{
  const Selection({Key? key}) : super(key: key);

  @override
  State<Selection> createState() => _Selection();
}

class _Selection extends State<Selection>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff212930),
    );
  }
}*/


import 'package:flutter_pj/func/array.dart';

import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  const Selection({Key? key}) : super(key: key);

  @override
  State<Selection> createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  List<int> array = [];
  String sortingResult = '';
  TextEditingController arraySizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateArray();
  }

  void generateArray() {
    int arraySize = int.tryParse(arraySizeController.text) ?? 10000;
    array = SortingHelper.generateRandomArray(arraySize, 10000);
    setState(() {});
  }

  void sortArray(List<int> Function(List<int>) sortingAlgorithm) {
    double sortingTime = SortingHelper.measureSortingTime(sortingAlgorithm, List.from(array));
    String sortingType = sortingAlgorithm == SortingHelper.selectionSort
        ? 'Selection Sort'
        : sortingAlgorithm == SortingHelper.shellSort
        ? 'Shell Sort'
        : 'Quick Sort';
    int arraySize = array.length;

    sortingResult = '''
      Sorting Type: $sortingType
      Array Size: $arraySize
      Sorting Time: $sortingTime seconds
    ''';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: arraySizeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Array Size'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateArray();
              },
              child: Text('Generate Array'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sortArray(SortingHelper.selectionSort);
              },
              child: Text('Sort Using Selection Sort'),
            ),
            SizedBox(height: 20),
            Text(
              sortingResult,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
