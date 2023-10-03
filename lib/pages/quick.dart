import 'package:flutter/material.dart';

class Quick extends StatefulWidget{
  const Quick({Key? key}) : super(key: key);

  @override
  State<Quick> createState() => _Quick();
}

class _Quick extends State<Quick>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff212930),
    );
  }
}