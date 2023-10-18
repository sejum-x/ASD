// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pj/backend/array.dart';
import 'package:fl_chart/fl_chart.dart';

class Compare extends StatefulWidget{
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _Compare();
}

class _Compare extends State<Compare> {
  bool showChart = false; // Початково графік не відображається
  bool? isSelection = true;
  bool? isShell = true;
  bool? isQuick = true;
  bool? isMerge = true;
  bool? isCounting = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Color(0xff212930),
            child: showChart ? _LineChart() : SizedBox(), // Відображаємо графік, якщо showChart == true
            //child: _LineChart(),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Color(0xff012430),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.46,
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Color(0xff012430),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xff912130),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('Selection'),
                          value: isSelection,
                          onChanged: (bool? newValue){
                          setState(() {
                             isSelection = newValue;
                          });
                          },
                          activeColor: Colors.orangeAccent,
                          checkColor: Colors.white,
                          tileColor: Colors.black12,
                          controlAffinity: ListTileControlAffinity.leading,
                          tristate: true,
                        ),

                        CheckboxListTile(
                          title: const Text('Shell'),
                          value: isShell,
                          onChanged: (bool? newValue){
                            setState(() {
                              isShell = newValue;
                            });
                          },
                          activeColor: Colors.orangeAccent,
                          checkColor: Colors.white,
                          tileColor: Colors.black12,
                          controlAffinity: ListTileControlAffinity.leading,
                          tristate: true,
                        ),

                        CheckboxListTile(
                          title: const Text('Quick'),
                          value: isQuick,
                          onChanged: (bool? newValue){
                            setState(() {
                              isQuick = newValue;
                            });
                          },
                          activeColor: Colors.orangeAccent,
                          checkColor: Colors.white,
                          tileColor: Colors.black12,
                          controlAffinity: ListTileControlAffinity.leading,
                          tristate: true,
                        ),

                        CheckboxListTile(
                          title: const Text('Merge'),
                          value: isMerge,
                          onChanged: (bool? newValue){
                            setState(() {
                              isMerge = newValue;
                            });
                          },
                          activeColor: Colors.orangeAccent,
                          checkColor: Colors.white,
                          tileColor: Colors.black12,
                          controlAffinity: ListTileControlAffinity.leading,
                          tristate: true,
                        ),

                        CheckboxListTile(
                          title: const Text('Counting'),
                          value: isCounting,
                          onChanged: (bool? newValue){
                            setState(() {
                              isCounting = newValue;
                            });
                          },
                          activeColor: Colors.orangeAccent,
                          checkColor: Colors.white,
                          tileColor: Colors.black12,
                          controlAffinity: ListTileControlAffinity.leading,
                          tristate: true,
                        ),

                        Row(
                          children: [
                        //SizedBox(height: 16), // Простір між кнопками
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Ваш код для кнопки "Sort"
                            });
                          },
                          child: Text('Sort'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16), // Додайте відступи
                          ),
                        ),
                        //SizedBox(height: 16), // Простір між кнопками
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
                        ],
                        ),
                      ],
                    ),
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

/*class sortOptions{
  bool? isShell;
}*/

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
  lineBarsData: lineBarsData,
  minX: 0,
  maxX: 500,
  minY: 0,
  maxY: 10,
);

List<LineChartBarData> get lineBarsData => [
  lineChartBarData1
];

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
      text = '2000';
      break;
    case 4:
      text = '4000';
      break;
    case 6:
      text = '6000';
      break;
    case 8:
      text = '8000';
      break;
    case 10:
      text = '10000';
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
  showTitles: true,
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

LineChartBarData get lineChartBarData1 => LineChartBarData(
  isCurved: true,
  color: Color(0xff624e66),
  barWidth: 6,
  isStrokeCapRound: true,
  dotData: FlDotData(show: false),
  belowBarData: BarAreaData(show: false),
  spots: const [
    FlSpot(4.133, 0.500),
    FlSpot(13.402, 1.000),
    FlSpot(87.100, 2.000),
    FlSpot(154.000, 4.000),
    FlSpot(234.000, 8.000),
    FlSpot(380.000, 10.000),
  ]
);




