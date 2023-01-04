import 'package:flutter/material.dart';
import 'package:repla_vinos/screens/index.dart';
import 'package:repla_vinos/screens/intro/intro_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Repla Vinos',
			routes: {
				'/': (context) => const IntroSlider(),
        'login': (context) => const LoginView(),
				'signup': (context) => const SignUpView(),
				'form_calculation': (context) => const FormCalculationScreen(),
			},
			initialRoute: '/',
			theme: ThemeData(
				useMaterial3: true,
				// primaryColor: const Color(0xff3c37ff),
				primaryColor: const Color(0xffa9fd85),
				textTheme: const TextTheme(
					bodyText1: TextStyle(
						fontSize: 18,
						color: Color(0xff111b31),
					),
				),
			)
		);
	}
}