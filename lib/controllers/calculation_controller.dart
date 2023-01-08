import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';
import 'dart:io' show Platform;

class CalculationController extends GetxController {
	final provider = ApiProvider();
	final fechaTextController = TextEditingController();
	final diametroTextController = TextEditingController();
	final plaguicidaTextController = TextEditingController();
	final dosisTextController = TextEditingController();
	final vinoTextController = CustomSegmentedController();
	List<Plaguicida> plaguicidas = <Plaguicida>[];
	Plaguicida selectedPlaguicida = Plaguicida();

	@override
	void onReady() {
		getPlaguicidas();

		vinoTextController.value = 'tinto';
		super.onReady();
	}

	void postCalculate(){
		var body = <String, dynamic>{};
		
		body['datos[vinificacion]'] = vinoTextController.value.toString().toUpperCase();
		body['datos[diametro]'] = diametroTextController.text;
		body['datos[plaguicida]'] = selectedPlaguicida.id;
		body['datos[dosis]'] = dosisTextController.text;
		body['datos[fecha_aplicacion]'] = fechaTextController.text;
		body['datos[so]'] = Platform.operatingSystem;

		print(body);
	}

	void getPlaguicidas() async {
		//Loading
		Get.dialog(
			const Center(
				child: CircularProgressIndicator(),
			),
			barrierDismissible: false
		);

		final response = await provider.plaguicidas();

		Get.back();

		if (response != null) {
			plaguicidas.clear();

			for (var element in response) {
				plaguicidas.add(element!);
			}

			selectedPlaguicida = plaguicidas.first;

			plaguicidaTextController.text = plaguicidas.first.plaguicida!;
		}
	}

	@override
	void onClose() {}
}