import 'package:flutter/material.dart';

class Shell extends StatefulWidget{
  const Shell({Key? key}) : super(key: key);

  @override
  State<Shell> createState() => _Shell();
}

class _Shell extends State<Shell>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff212930),
    );
  }
}