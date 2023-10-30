/*
import 'package:flutter/material.dart';

class Count extends StatefulWidget{
  const Count({Key? key}) : super(key: key);

  @override
  State<Count> createState() => _Count();
}

class _Count extends State<Count>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff212930),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_pj/func/array.dart';

class Count extends StatefulWidget {
  const Count({Key? key}) : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  List<int> array = [];
  String sortingResult = '';
  List<int> sizes = [1024, 4096, 16384, 65536, 262144];
  List<Map<String, dynamic>> sortingResults = [];

  @override
  void initState() {
    super.initState();
  }

  void generateArray() {
    sortingResults.clear();
    for (var sortingAlgorithm in [SortingHelper.selectionSort, SortingHelper.shellSort, SortingHelper.quickSort, SortingHelper.countingSort, SortingHelper.mergeSort]) {
      List<double> sortingTimes = [];
      for (int size in sizes) {
        array = SortingHelper.generateRandomArray(size, 10000);
        double sortingTime = SortingHelper.measureSortingTime(sortingAlgorithm, List.from(array));
        sortingTimes.add(sortingTime);
      }
      String sortingType = sortingAlgorithm == SortingHelper.selectionSort
          ? 'Selection'
          : sortingAlgorithm == SortingHelper.shellSort
          ? 'Shell'
          : sortingAlgorithm == SortingHelper.quickSort
          ? 'Quick'
          : sortingAlgorithm == SortingHelper.countingSort
          ? 'Counting'
          : 'Merge';

      sortingResults.add({
        'SortingType': sortingType,
        'SortingTimes': sortingTimes,
      });
    }
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateArray();
              },
              child: Text('Generate Array'),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: <DataColumn>[
                DataColumn(label: Text('Array Size')),
                for (int size in sizes) DataColumn(label: Text(size.toString())),
              ],
              rows: sortingResults
                  .map(
                    (result) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(result['SortingType'].toString())),
                    for (double time in result['SortingTimes']) DataCell(Text(time.toStringAsFixed(4))),
                  ],
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
