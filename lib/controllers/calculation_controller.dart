import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repla_vinos/models/calculo_response_model.dart';
import 'package:repla_vinos/models/form_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';
import 'package:repla_vinos/providers/db_provider.dart';

class CalculationController extends GetxController {
	final provider = ApiProvider();
	final fechaTextController = TextEditingController();
	final diametroTextController = TextEditingController();
	final plaguicidaTextController = TextEditingController();
	final dosisTextController = TextEditingController();
	final vinoTextController = CustomSegmentedController();
	List<Plaguicida> plaguicidas = [];
	Plaguicida selectedPlaguicida = Plaguicida();

	@override
	void onReady(){
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
			final DateFormat formatter = DateFormat('yyyy/MM/dd');
			var fecha = DateFormat('dd/MM/yyyy').parse(fechaTextController.text);

		  	var body = <String, dynamic>{};
		
			body['datos[vinificacion]'] = vinoTextController.value.toString().toUpperCase();
			body['datos[diametro]'] = diametroTextController.text;
			body['datos[plaguicida]'] = selectedPlaguicida.id;
			body['datos[dosis]'] = dosisTextController.text;
			body['datos[fecha_aplicacion]'] = formatter.format(fecha);
			body['datos[so]'] = defaultTargetPlatform.name.toString();

			final connectivityResult = await (Connectivity().checkConnectivity());

			if (connectivityResult == ConnectivityResult.none) {
				Resultado resultado = _calculo();

				Get.back();

				Get.toNamed('results', arguments: [{
					'resultado': resultado,
				}]);

				return;
			}

			// await DBProvider.db.insertForm(FormModel(
			// 	datosVinificacion: vinoTextController.value.toString().toUpperCase(),
			// 	datosDiametro: diametroTextController.text,
			// 	datosPlaguicida: selectedPlaguicida.id.toString(),
			// 	datosDosis: dosisTextController.text,
			// 	datosFechaAplicacion: formatter.format(fecha),
			// 	datosSo: defaultTargetPlatform.name.toString()
			// ));

			final response = await provider.calculo(body);

			Get.back();

			if (response != null) {

				Get.toNamed('results', arguments: [{
					'resultado': response.resultado,
				}]);
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}
		} catch (e) {
			Get.back();
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		  print(e.toString());
		}
	}

	Resultado _calculo() {
		var resultado = Resultado();



		resultado.titulo = "Azoxystrobin";
		resultado.txtBq1 = [
			"Nivel aproximado de residuo en vino ",
			"TINTO",
			" en base a fecha de cosecha estimada. "
		];

		resultado.txtBq2 = [
			"Resultados obtenidos en base a la fecha de aplicación ",
			"20-01-2023",
			", uva ",
			"20(mm)",
			" y dosis ",
			"20(g activo/ha)."
		];

		resultado.f1 = "0.1 (mg/kg) 22-01-2023";
		resultado.f2 = "0.05 (mg/kg) 20-02-2023";
		resultado.f3 = "0.01 (mg/kg) 28-04-2023";
		resultado.f4 = "0.04 (mg/kg) 01-03-2023";
		resultado.pie = "Las fechas de cosecha son referenciales y han sido obtenidas a partir de curvas de disperción en campo y estudios de traspaso de residuos de poluguicidas en el proceso de vinificación.";

		return resultado;
	}

	void getPlaguicidas() async {
		try {
		  	//Loading
			Get.dialog(
				const Center(
					child: CircularProgressIndicator(),
				),
				barrierDismissible: false
			);

			List<Plaguicida>? resp = await DBProvider.db.getAllPlagicidas();

			if (resp == null) {
				final response = await provider.plaguicidas();

				if (response != null) {
					plaguicidas.clear();

					for (var element in response) {
						plaguicidas.add(element!);
						await DBProvider.db.insertPlagicida(element);
					}
				}
			}

			if (resp != null) {
				print("Plagicidas Desde SQLite");
				plaguicidas.clear();

				for (var element in resp) {
					plaguicidas.add(element);
				}
			}

			Get.back();	

			selectedPlaguicida = plaguicidas.first;

			plaguicidaTextController.text = plaguicidas.first.plaguicida!;
			
		} catch (e) {
			Get.back();
			print(e.toString());
		}
	}

	@override
	void onClose() {}
}