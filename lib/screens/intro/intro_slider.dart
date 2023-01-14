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
		List<Widget> expanded = [
			Expanded(
				flex: 1,
				child: Container(
					color: const Color.fromARGB(180, 219, 234, 109),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 170, 214, 8))),
							Image.network('https://api.replavinos.cl/images/logoid.png', width: 200),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: Text('Esta Aplicación forma parte del Proyecto del Consorcio I+D Vinos de Chile: Curvas de Disperción, Tasas de Transferencia y Carencias para Pluguicidas. Esta es una herramienta que permite estimar de manera referencial, periodos de resguardo para el uso de plaguicidas en el sector vitivinícola.', 
								style: textTheme.bodyMedium
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
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 153, 156, 0))),
							Image.network('https://api.replavinos.cl/images/logo_corfo.png', width: 200),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: Text('Contó con el apoyo de CORFO.', 
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
					child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceAround,
						children:  [
							Text('Repla Vinos', style: textTheme.headline3?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xff119c45))),
							Image.network('https://api.replavinos.cl/images/sidal.png', width: 200),
							Padding(
								padding: const EdgeInsets.symmetric(horizontal: 15),
								child: Text('Fue desarrollada por SIDAL', 
								style: textTheme.bodyLarge
								),
							),
						],
					),
				),
			),
		];

		return Scaffold(
			body: Stack(
				children: [
					(size.width > 800) ? Row(
						children: expanded,
					) : Column(
						mainAxisSize: MainAxisSize.max,
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: expanded,
					),

					Positioned.fill(
						bottom: 50,						
						child: Container(
							alignment: Alignment.bottomCenter,
							width: 200,
							height: 55,
							child: ElevatedButton(
								style: ElevatedButton.styleFrom(
									padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
									backgroundColor: const Color(0xffa3fb82),
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(15),
									),
								),
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
								child: Row(
									mainAxisSize: MainAxisSize.min,
									children: const [
										Text('Siguiente', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
										Icon(Icons.arrow_forward_ios_rounded)
									],
								),
							),
						),
					)
				],
			),
		);
	}
}