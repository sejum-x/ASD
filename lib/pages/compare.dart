// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pj/func/array.dart';
import 'package:fl_chart/fl_chart.dart';

class Compare extends StatefulWidget{
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _Compare();
}

bool? isSelection = false;
bool? isShell = true;
bool? isQuick = true;
bool? isMerge = true;
bool? isCounting = true;

bool? is1024 = true;
bool? is4096 = true;
bool? is16384 = true;
bool? is65536 = true;
bool? is262144 = false;
bool? is1048576 = false;
bool? is4194304 = false;


List<int> array = [];
String sortingResult = '';
List<int> sizes = [];
//List<int> sizes = [1024, 4096, 16384, 65536, 262144, 1048576, 4194304];
List<Map<String, dynamic>> sortingResults = [];

List<String> chartHeight = ["0.1","1", "5", "10", "15", "20", "30", "50"];
String choosenHeight = "10";

List<String> chartWidth = ["100", "200", "400", "500", "1000", "1500", "2000", "3000"];
String choosenWidth = "500";

class SortingInfo {
  final String algorithmName;
  final int size;
  final double sortingTime;

  SortingInfo(this.algorithmName, this.size, this.sortingTime);
}


class _Compare extends State<Compare> {
  bool showChart = false; // Початково графік не відображається
  /*bool? isSelection = true;
  bool? isShell = true;
  bool? isQuick = true;
  bool? isMerge = true;
  bool? isCounting = true;*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.45,
            color: Color(0xff212930),
            child: showChart ? _LineChart() : SizedBox(), // Відображаємо графік, якщо showChart == true
            //child: _LineChart(),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.55,
            color: Color(0xff012430),
            child: Column(
              children: [
                Container(
                  color: Color(0x0f912130),
                  height: MediaQuery.of(context).size.height * 0.40,
                  child:SingleChildScrollView(
                    child:

                    Column(
                      children: [
                        DataTable(
                        dataRowHeight: 50, // Ви можете змінити висоту рядків за потребою
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('Array Size', style: TextStyle(color: Colors.white)),
                          ),
                          for (int size in sizes)
                            DataColumn(
                              label: Text(size.toString(), style: TextStyle(color: Colors.white)),
                            ),
                        ],
                        rows: sortingResults
                            .map(
                              (result) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text(
                                  result['SortingType'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              for (double time in result['SortingTimes'])
                                DataCell(
                                  Text(
                                    time.toStringAsFixed(4),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        )
                            .toList(),
                  ),

                      ],
                    ),

    ),



                ),

                Expanded(
                  child:
                    Row(
                      children: [
                        //chose size
                        Container(
                            color: Color(0xff3b4956),
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  "Choose size:",
                                  // Встановлюємо вирівнювання тексту вліво
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                ),

                                CheckboxListTile(
                                  title: const Text('1024',
                                    style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  ),
                                  value: is1024,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is1024 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  selectedTileColor: Colors.white,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text(
                                    '4096',
                                    style: TextStyle(
                                    color: Colors.white,
                                    ),
                                  ),
                                  value: is4096,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is4096 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text('16384',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: is16384,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is16384 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text('65536',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: is65536,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is65536 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text('262144',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: is262144,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is262144 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text('1048576',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: is1048576,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is1048576 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                                CheckboxListTile(
                                  title: const Text('4194304',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  value: is4194304,
                                  onChanged: (bool? newValue){
                                    setState(() {
                                      is4194304 = newValue;
                                    });
                                  },
                                  activeColor: Colors.orangeAccent,
                                  checkColor: Colors.white,
                                  tileColor: Colors.black12,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  tristate: true,
                                ),
                              ],


                            )
                        ),

                        //Show method
                        Container(
                          color: Color(0xff3b4956),
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Text(
                                "Show method:",
                                // Встановлюємо вирівнювання тексту вліво
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                                    CheckboxListTile(
                                      title: const Text('Selection',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      value: isSelection,
                                      onChanged: (bool? newValue){
                                        setState(() {
                                          isSelection = newValue;
                                        });
                                      },
                                      activeColor: Colors.red,
                                      checkColor: Colors.white,
                                      tileColor: Colors.white10,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      tristate: true,
                                    ),

                                    CheckboxListTile(
                                      title: const Text('Shell',
                                        style: TextStyle(
                                          color: Colors.purple,
                                        ),),
                                      value: isShell,
                                      onChanged: (bool? newValue){
                                        setState(() {
                                          isShell = newValue;
                                        });
                                      },
                                      activeColor: Colors.purple,
                                      checkColor: Colors.white,
                                      tileColor: Colors.black12,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      tristate: true,
                                    ),

                                    CheckboxListTile(
                                      title: const Text('Quick',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),),
                                      value: isQuick,
                                      onChanged: (bool? newValue){
                                        setState(() {
                                          isQuick = newValue;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                      checkColor: Colors.white,
                                      tileColor: Colors.black12,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      tristate: true,
                                    ),

                                    CheckboxListTile(
                                      title: const Text('Merge',
                                        style: TextStyle(
                                          color: Colors.pink,
                                        ),),
                                      value: isMerge,
                                      onChanged: (bool? newValue){
                                        setState(() {
                                          isMerge = newValue;
                                        });
                                      },
                                      activeColor: Colors.pink,
                                      checkColor: Colors.white,
                                      tileColor: Colors.black12,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      tristate: true,
                                    ),

                                    CheckboxListTile(
                                      title: const Text('Counting',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),),
                                      value: isCounting,
                                      onChanged: (bool? newValue){
                                        setState(() {
                                          isCounting = newValue;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      tileColor: Colors.black12,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      tristate: true,
                                    ),

                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Text(
                                    "Chose chart height:",
                                    style: TextStyle(color: Colors.white),


                                  ),
                                  SizedBox(width: 16),
                                  DropdownButton(

                                    hint: Text("Select height",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    dropdownColor: Colors.grey,
                                    value: choosenHeight,
                                    onChanged: (newValue){
                                      setState(() {
                                        choosenHeight = newValue!;
                                      });
                                    },
                                    items: chartHeight.map((valueItem){
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                  ),


                                ],
                              ),

                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Text(
                                    "Chose chart width:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 16),
                                  DropdownButton(

                                    hint: Text("Select height",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    dropdownColor: Colors.grey,
                                    value: choosenWidth,
                                    onChanged: (newVal){
                                      setState(() {
                                        choosenWidth = newVal!;
                                      });
                                    },
                                    items: chartWidth.map((valItem){
                                      return DropdownMenuItem(
                                        value: valItem,
                                        child: Text(valItem),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                              SizedBox(width: 16), // Простір між кнопками
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    sizes.clear();

                                    if (is1024 == true) {
                                      sizes.add(1024);
                                    }

                                    if (is4096 == true) {
                                      sizes.add(4096);
                                    }

                                    if (is16384 == true) {
                                      sizes.add(16384);
                                    }

                                    if (is65536 == true) {
                                      sizes.add(65536);
                                    }

                                    if (is262144 == true) {
                                      sizes.add(262144);
                                    }

                                    if (is1048576 == true) {
                                      sizes.add(1048576);
                                    }

                                    if (is4194304 == true) {
                                      sizes.add(4194304);
                                    }
                                    generateArray();
                                  });
                                },
                                child: Text('Sort'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16), // Додайте відступи
                                ),
                              ),
                              SizedBox(width: 16), // Простір між кнопками
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showChart = !showChart; // Змінюємо стан, коли кнопка натиснута
                                  });
                                },
                                child: Text(showChart ? 'Hide' : 'Show'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16), // Додайте відступи
                                ),
                              ),
                                  SizedBox(width: 16),

                                  //


                              ],
                              ),
                            ],
                          ),

                        ),

                      ]
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//table

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
}

class _LineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      swapAnimationDuration: const Duration(milliseconds: 250),
      sampleData1,
    );
  }
}

LineChartData get sampleData1 => LineChartData(
  gridData: gridData,
  titlesData: titlesData,
  borderData: boarderData,
  lineBarsData: getLineBarsData(), // Use the dynamic data here
  minX: 0,
  maxX: double.tryParse(choosenWidth), // Adjust these values as needed
  minY: 0,
  maxY: double.tryParse(choosenHeight), // Adjust these values as needed
);

List<LineChartBarData> getLineBarsData() {


  final List<LineChartBarData> lineBarsData = [];

  if (isSelection == true) {
    lineBarsData.add(selectionLineChartBarData);
  }

  if (isShell == true) {
    lineBarsData.add(shellLineChartBarData);
  }

  if (isQuick == true) {
    lineBarsData.add(quickLineChartBarData);
  }

  if (isMerge == true) {
    lineBarsData.add(mergeLineChartBarData);
  }

  if (isCounting == true) {
    lineBarsData.add(countingLineChartBarData);
  }

  return lineBarsData;
}

LineChartBarData get quickLineChartBarData {
  List<LineChartBarData> lines = [];

  // Фільтруємо дані для алгоритму Quick
  var quickData = sortingResults.firstWhere(
          (result) => result['SortingType'] == 'Quick',
      orElse: () => {'SortingType': 'Quick', 'SortingTimes': []}
  );
  List<double> quickSortingTimes = quickData['SortingTimes'];

  List<FlSpot> spots = [];

  for (int i = 0; i < quickSortingTimes.length; i++) {
    // Використовуйте час виконання (ось X) та розмір масиву (ось Y)
    double executionTime = quickSortingTimes[i];
    double arraySize = sizes[i].toDouble() / 1000;
    spots.add(FlSpot(arraySize, executionTime));

    // Виводимо точку у консоль
    print("Point - X: $arraySize, Y: $executionTime");
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    curveSmoothness: 0.1,
    color: Colors.blue, // Налаштуйте колір лінії
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );
}

///////////
LineChartBarData get selectionLineChartBarData {
  List<LineChartBarData> lines = [];

  // Фільтруємо дані для алгоритму Quick
  var selectionData = sortingResults.firstWhere(
          (result) => result['SortingType'] == 'Selection',
      orElse: () => {'SortingType': 'Selection', 'SortingTimes': []}
  );
  List<double> selectionSortingTimes = selectionData['SortingTimes'];

  List<FlSpot> spots = [];

  for (int i = 0; i < selectionSortingTimes.length; i++) {
    // Використовуйте час виконання (ось X) та розмір масиву (ось Y)
    double executionTime = selectionSortingTimes[i];
    double arraySize = sizes[i].toDouble() / 1000;
    spots.add(FlSpot(arraySize, executionTime));

    // Виводимо точку у консоль
    print("Point - X: $arraySize, Y: $executionTime");
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    curveSmoothness: 0.08,
    color: Colors.red, // Налаштуйте колір лінії
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );

}

///////////
LineChartBarData get shellLineChartBarData {
  List<LineChartBarData> lines = [];

  // Фільтруємо дані для алгоритму Quick
  var shellData = sortingResults.firstWhere(
          (result) => result['SortingType'] == 'Shell',
      orElse: () => {'SortingType': 'Shell', 'SortingTimes': []}
  );
  List<double> shellSortingTimes = shellData['SortingTimes'];

  List<FlSpot> spots = [];

  for (int i = 0; i < shellSortingTimes.length; i++) {
    // Використовуйте час виконання (ось X) та розмір масиву (ось Y)
    double executionTime = shellSortingTimes[i];
    double arraySize = sizes[i].toDouble() / 1000;
    spots.add(FlSpot(arraySize, executionTime));

    // Виводимо точку у консоль
    print("Point - X: $arraySize, Y: $executionTime");
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    curveSmoothness: 0.1,
    color: Colors.purple, // Налаштуйте колір лінії
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );
}

///////////
LineChartBarData get mergeLineChartBarData {
  List<LineChartBarData> lines = [];

  // Фільтруємо дані для алгоритму Quick
  var mergeData = sortingResults.firstWhere(
          (result) => result['SortingType'] == 'Merge',
      orElse: () => {'SortingType': 'Merge', 'SortingTimes': []}
  );
  List<double> mergeSortingTimes = mergeData['SortingTimes'];

  List<FlSpot> spots = [];

  for (int i = 0; i < mergeSortingTimes.length; i++) {
    // Використовуйте час виконання (ось X) та розмір масиву (ось Y)
    double executionTime = mergeSortingTimes[i];
    double arraySize = sizes[i].toDouble() / 1000;
    spots.add(FlSpot(arraySize, executionTime));

    // Виводимо точку у консоль
    print("Point - X: $arraySize, Y: $executionTime");
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    curveSmoothness: 0.1,
    color: Colors.pink, // Налаштуйте колір лінії
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );
}

///////////
LineChartBarData get countingLineChartBarData {
  List<LineChartBarData> lines = [];

  // Фільтруємо дані для алгоритму Quick
  var countData = sortingResults.firstWhere(
          (result) => result['SortingType'] == 'Counting',
      orElse: () => {'SortingType': 'Counting', 'SortingTimes': []}
  );
  List<double> countSortingTimes = countData['SortingTimes'];

  List<FlSpot> spots = [];

  for (int i = 0; i < countSortingTimes.length; i++) {
    // Використовуйте час виконання (ось X) та розмір масиву (ось Y)
    double executionTime = countSortingTimes[i];
    double arraySize = sizes[i].toDouble() / 1000;
    spots.add(FlSpot(arraySize, executionTime));

    // Виводимо точку у консоль
    print("Point - X: $arraySize, Y: $executionTime");
  }

  return LineChartBarData(
    spots: spots,
    isCurved: true,
    curveSmoothness: 0.1,
    color: Colors.green, // Налаштуйте колір лінії
    isStrokeCapRound: true,
    belowBarData: BarAreaData(show: false),
  );
}




FlTitlesData get titlesData => FlTitlesData(
  bottomTitles: AxisTitles(
    sideTitles: bottomTitles,
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  leftTitles: AxisTitles(
    sideTitles: leftTitles(),
  )
);

Widget leftTitlesWidget(double value, TitleMeta meta){
  const style = TextStyle(
   fontSize: 15,
   fontWeight: FontWeight.bold,
   color: Colors.grey,
  );
  String text;
  switch (value.toInt()){
    case 2:
      text = '2';
      break;
    case 4:
      text = '4';
      break;
    case 6:
      text = '6';
      break;
    case 8:
      text = '8';
      break;
    case 10:
      text = '10';
      break;
    case 12:
      text = '12';
      break;
    case 14:
      text = '14';
      break;
    case 16:
      text = '16';
      break;
    case 18:
      text = '18';
      break;
    case 20:
      text = '20';
      break;
    default:
      return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.center,);
}

SideTitles leftTitles() => SideTitles(
  getTitlesWidget: leftTitlesWidget,
  showTitles: true,
  interval: 1,
  reservedSize: 40,
);

Widget bottomTitlesWidget(double value, TitleMeta meta){
  const style = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color:  Colors.grey,
  );
  Widget text;
  switch (value.toInt()){
    case 1:
      text = const Text('1024', style: style);
      break;
    case 4:
      text = const Text('4096', style: style);
      break;
    case 16:
      text = const Text('16384', style: style);
      break;
    case 65:
      text = const Text('65536', style: style);
      break;
    case 182:
      text = const Text('262144', style: style);
      break;
    case 320:
      text = const Text('1048576', style: style);
      break;
    case 480:
      text = const Text('4194304', style: style);
      break;
    default:
      text = const Text(' ');
      break;
  }
  return SideTitleWidget(
    child: text,
    axisSide: meta.axisSide,
    space: 10,
  );
}

SideTitles get bottomTitles => SideTitles(
  showTitles: false,
  reservedSize: 32,
  interval: 1,
  getTitlesWidget: bottomTitlesWidget,
);

FlGridData get gridData =>  FlGridData(show: true);

FlBorderData get boarderData => FlBorderData(
  show: true,
  border: Border(
    bottom:
      BorderSide(color: Colors.grey, width: 4),
    left: const BorderSide(color: Colors.grey),
    right: const BorderSide(color: Colors.transparent),
    top: const BorderSide(color: Colors.transparent),
  ),
);