import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:repla_vinos/screens/text/intro_text.dart';


final pages = [
  PageViewModel(
    pageColor: const Color(0xFF03A9F4),
    iconImageAssetPath: 'assets/logoid.png',
    title: const Text(intro_tittle_p1),
    body: const Text(intro_text_p1),
    textStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    mainImage: Image.asset(
      'assets/logoid.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    )
  ),
   PageViewModel(
    pageColor: const Color(0xFF8BC34A),
    iconImageAssetPath: 'assets/logo_corfo.png',
    title: const Text(intro_tittle_p2),
    body: const Text(intro_text_p2),
    textStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    mainImage: Image.asset(
      'assets/logo_corfo.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
  ),
  PageViewModel(
    pageColor: const Color(0xFF607D8B),
    iconImageAssetPath: 'assets/sidal.png',
    title: const Text(intro_tittle_p3),
    body: const Text(intro_text_p3),
    textStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    mainImage: Image.asset(
      'assets/sidal.png',
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
  )
];