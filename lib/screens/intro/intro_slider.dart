import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:repla_vinos/screens/intro/intro_screen.dart';


class IntroSlider extends StatelessWidget {
  const IntroSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repla Vinos',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          onTapDoneButton: () {
           //Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginView()),);
           Navigator.pushNamed(context, 'login');
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0
          ),
        )
      ),
    );
  }
}