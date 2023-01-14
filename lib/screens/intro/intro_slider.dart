import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:repla_vinos/controllers/slider_controller.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:repla_vinos/screens/intro/intro_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class IntroSlider extends StatelessWidget {
	IntroSlider({super.key});

	final SliderController calculationController = Get.put(SliderController());

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;
		var size = MediaQuery.of(context).size;

		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Repla Vinos',
			theme: ThemeData(
				primarySwatch: Colors.lightGreen,
			),
			home: (kIsWeb) ? introSliderWeb(textTheme, size) : IntroViewsFlutter(
				pages,
				onTapDoneButton: () {
					try {
						var data = GetStorage().read('user');
						var user = (data is Usuario) ? data : Usuario.fromJson(data);

						if (user.llaveApi != null) {
							Get.toNamed("form_calculation");						  
						}else{
							Get.offAllNamed("login");
						}
					} catch (e) {
						Get.offAllNamed("login");
					}
				},
				pageButtonTextStyles: const TextStyle(
					color: Colors.white,
					fontSize: 18.0
				),
			),
		);
	}

	Widget introSliderWeb(TextTheme textTheme, Size size){
		var imageSize = (size.width > 600) ? 200.0 : 150.0;

		List<Widget> expanded = [
			Expanded(
				flex: 1,
				child: Container(
					color: const Color.fromARGB(180, 219, 234, 109),
					height: size.height,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 170, 214, 8))),
							Image.network('https://api.replavinos.cl/images/logoid.png', width: imageSize ),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: AutoSizeText('Esta Aplicación forma parte del Proyecto del Consorcio I+D Vinos de Chile: Curvas de Disperción, Tasas de Transferencia y Carencias para Pluguicidas. Esta es una herramienta que permite estimar de manera referencial, periodos de resguardo para el uso de plaguicidas en el sector vitivinícola.', 
								style: TextStyle(fontSize: size.width * 0.005),
								),
							),
						],
					),
				),
			),
			Expanded(
				flex: 1,
				child: Container(
					color: const Color.fromARGB(180, 219, 222, 78),
					height: size.height,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 153, 156, 0))),
							Image.network('https://api.replavinos.cl/images/logo_corfo.png', width: imageSize),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: AutoSizeText('Contó con el apoyo de CORFO.', 
								style: textTheme.bodyLarge
								),
							),
						],
					),
				)
			),
			Expanded(
				flex: 1,
				child: Container(
					color: const Color.fromARGB(180, 173, 197, 83),
					height: size.height,
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xff119c45))),
							Image.network('https://api.replavinos.cl/images/sidal.png', width: imageSize),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: AutoSizeText('Fue desarrollada por SIDAL', 
								style: textTheme.bodyLarge
								),
							),
						],
					),
				),
			),
		];

		return Scaffold(
			floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
			floatingActionButton: FloatingActionButton(
				backgroundColor: const Color(0xff119c45),
				onPressed: () {
					try {
						var data = GetStorage().read('user');
						var user = (data is Usuario) ? data : Usuario.fromJson(data);

						if (user.llaveApi != null) {
							Get.toNamed("form_calculation");						  
						}else{
							Get.offAllNamed("login");
						}
					} catch (e) {
						Get.offAllNamed("login");
					}
				},
				child: const Icon(Icons.arrow_forward_ios_rounded),
			),
			body: (size.width > 800) ? Row(
				children: expanded,
			) : Column(
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: expanded,
			),
		);
	}
}