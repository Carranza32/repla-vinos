import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
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
	List<Plaguicida?> plaguicidas = [];

	@override
	void onReady() {
		getPlaguicidas();
		super.onReady();
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

			plaguicidas = response;
		}
	}

	@override
	void onClose() {}
}