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
      backgroundColor: Color(0xFFABB8C4),
    );
  }
}