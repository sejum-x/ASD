import 'package:flutter/material.dart';

class Selection extends StatefulWidget{
  const Selection({Key? key}) : super(key: key);

  @override
  State<Selection> createState() => _Selection();
}

class _Selection extends State<Selection>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFABB8C4),
    );
  }
}