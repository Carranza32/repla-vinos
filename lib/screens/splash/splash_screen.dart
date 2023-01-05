import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

	@override
	Widget build(BuildContext context) {
		// ignore: unused_local_variable
		SplashController controller = Get.put(SplashController());

		return const Scaffold(
			body: Center(
				child: FlutterLogo(
					size: 75,
				),
			),
		);
	}
}