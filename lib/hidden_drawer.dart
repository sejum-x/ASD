// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pj/pages/compare.dart';
import 'package:flutter_pj/pages/selection.dart';
import 'package:flutter_pj/pages/shell.dart';
import 'package:flutter_pj/pages/quick.dart';
import 'package:flutter_pj/pages/merge.dart';
import 'package:flutter_pj/pages/count.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  List<ScreenHiddenDrawer> _pages = [] ;

  final myTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Color(0xFFF4F6F3),
  );

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Compare',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Compare()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Selection',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Selection()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Shell',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Shell()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Quick',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Quick()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Merge',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Merge()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Count',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color(0xff6c8399),
          ),
          Count()
      ),
    ];
  }

  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Color(0xFF171C21),
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 33,
      contentCornerRadius: 20,
      withShadow: false,
    );
  }
}
