import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';

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

	void postCalculate() async {
		try {
			//Loading
			Get.dialog(
				const Center(
					child: CircularProgressIndicator(),
				),
				barrierDismissible: false
			);

		  	var body = <String, dynamic>{};
		
			body['datos[vinificacion]'] = vinoTextController.value.toString().toUpperCase();
			body['datos[diametro]'] = diametroTextController.text;
			body['datos[plaguicida]'] = selectedPlaguicida.id;
			body['datos[dosis]'] = dosisTextController.text;
			body['datos[fecha_aplicacion]'] = fechaTextController.text;
			body['datos[so]'] = defaultTargetPlatform.name.toString();

			final response = await provider.calculo(body);

			Get.back();

			if (response != null) {
				print(response);
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}

			print(body);
		} catch (e) {
			Get.back();
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		  print(e.toString());
		}
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