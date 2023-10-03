import 'package:flutter/material.dart';
import 'package:flutter_pj/hidden_drawer.dart';

import 'pages/compare.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    //Color mainColor = Color(0xffb74093);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HiddenDrawer(),
      theme: ThemeData(primarySwatch: MaterialColor(
       0xff141a20,
       <int, Color>{
        50: Color(0xff6c8399), // Шкала тонів від 50 до 900
        100: Color(0xff6c8399),
        200: Color(0xff6c8399),
        300: Color(0xff6c8399),
        400: Color(0xff6c8399),
        500: Color(0xff6c8399), // Основний колір
        600: Color(0xff6c8399),
        700: Color(0xff6c8399),
        800: Color(0xff6c8399),
        900: Color(0xff6c8399),
        },
      ),
      ),
    );

  }
}
