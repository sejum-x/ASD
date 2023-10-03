// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Compare extends StatefulWidget{
  const Compare({Key? key}) : super(key: key);

  @override
  State<Compare> createState() => _Compare();
}

class _Compare extends State<Compare> {
  bool showChart = false; // Початково графік не відображається

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212930),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xff212930),
            child: showChart ? _LineChart() : SizedBox(), // Відображаємо графік, якщо showChart == true
            //child: _LineChart(),
          ),
          Expanded(
            child: Container(
              color: Color(0xffffffff),
              padding: EdgeInsets.all(16.0), // Додайте відступи для красивого вигляду
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Вирівняти кнопку зліва
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showChart = !showChart; // Змінюємо стан, коли кнопка натиснута
                      });
                    },
                    child: Text(showChart ? 'Hide' : 'Show'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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




