import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:repla_vinos/controllers/slider_controller.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:repla_vinos/screens/intro/intro_screen.dart';


class IntroSlider extends StatelessWidget {
	IntroSlider({super.key});

	final SliderController calculationController = Get.put(SliderController());

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Repla Vinos',
			theme: ThemeData(
				primarySwatch: Colors.lightGreen,
			),
			home: IntroViewsFlutter(
					pages,
					onTapDoneButton: () {
						try {
							Usuario user = GetStorage().read('user');

							Get.toNamed("form_calculation");
						} catch (e) {
						  	Get.offAllNamed("login");
						}
					},
					pageButtonTextStyles: const TextStyle(
						color: Colors.white,
						fontSize: 18.0
					),
				)
		);
	}
}