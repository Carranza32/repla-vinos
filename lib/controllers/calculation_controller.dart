import 'dart:ffi';
import 'dart:io';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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
import 'package:http/http.dart' as http;
import 'dart:math';

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

			bool connection = await InternetConnectionCheckerPlus().hasConnection;

      //Si no hay conexión a internet, se guarda en la base de datos local
			if (!connection) {
        FormModel form = FormModel(
          datosVinificacion: vinoTextController.value.toString().toUpperCase(),
          datosDiametro: diametroTextController.text,
          datosPlaguicida: selectedPlaguicida.id.toString(),
          datosDosis: dosisTextController.text,
          datosFechaAplicacion: formatter.format(fecha),
          datosSo: defaultTargetPlatform.name.toString()
        );

        await DBProvider.db.insertForm(form);

				Resultado resultado = _calculo(form, selectedPlaguicida);

				Get.back();

				Get.toNamed('results', arguments: [{
					'resultado': resultado,
				}]);

				return;
			}

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

	Resultado _calculo(FormModel form, Plaguicida plaguicida) {


	//Estas variables no vienen en form y son necesarias.
	double k = double.tryParse(plaguicida.k ?? "0.024") ?? 0;
	double ftt = double.tryParse(plaguicida.ftt ?? "0.105") ?? 0;
	double ftb = double.tryParse(plaguicida.ftb ?? "0.160") ?? 0;

	final VALCMA = 1.97832;
	final VALCMB = 0.0018; 
	final VALCMC = -0.14544;

	double LMR_1 = 0.1; 
	double LMR_2 = 0.05; 
	double LMR_3 = 0.01; 
	double LMR_4 = 0.04;

	double diametro = double.parse(form.datosDiametro);
	double dosis = double.parse(form.datosDosis);
	double cm = 0.0;

	cm = VALCMA + (VALCMB * dosis)+(VALCMC * diametro);

	if(cm <= 3){k = k/0.4;}
	else if(cm <= 4.5){k = k/0.7;}
	else{k = k;}

	//******** LMR / FTT o FTB / CM ********//
	double ftx = (form.datosVinificacion == 'TINTO' ? ftt : ftb);
	cm = (cm <= 0 ? 1 : cm);
	//ftx = (ftx <= 0 ? 1 : ftx);
	//LMR_1 = (LMR_1 <= 0 ? 1 : LMR_1);


	double dias_p1 = log(LMR_1) - log(ftx) + log(cm);
	double dias_p2 = log(LMR_2) - log(ftx) + log(cm);
	double dias_p3 = log(LMR_3) - log(ftx) + log(cm);
	double dias_p4 = log(LMR_4) - log(ftx) + log(cm);

	double dias_q1 = (dias_p1)/(k *-1);
	double dias_q3 = (dias_p3)/(k *-1);
	double dias_q4 = (dias_p4)/(k *-1);
	double dias_q2 = (dias_p2)/(k *-1);

	List<String> dateSplit = form.datosFechaAplicacion.split('/');
	String day = dateSplit[2].toString();
	String month = dateSplit[1].toString(); 
	String year = dateSplit[0].toString();

	DateTime appdate = DateTime.parse('$year-$month-$day');
	DateTime fecha_1 = appdate.add(Duration(days: dias_q1.round()));
	DateTime fecha_2 = appdate.add(Duration(days: dias_q2.round()));
	DateTime fecha_3 = appdate.add(Duration(days: dias_q3.round()));
	DateTime fecha_4 = appdate.add(Duration(days: dias_q4.round()));


    //Aqui va la respuesta
		var resultado = Resultado();

		resultado.titulo = form.datosPlaguicida;
		resultado.txtBq1 = [
			"Nivel aproximado de residuo en vino ",
			form.datosVinificacion,
			" en base a fecha de cosecha estimada. "
		];

		resultado.txtBq2 = [
			"Resultados obtenidos en base a la fecha de aplicación ",
			form.datosFechaAplicacion,
			", uva ",
			"${form.datosDiametro}(mm)",
			" y dosis ",
			"${form.datosDosis}(g activo/ha)."
		];

		resultado.f1 = "$LMR_1 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_1)}";
		resultado.f2 = "$LMR_2 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_2)}";
		resultado.f3 = "$LMR_3 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_3)}";
		resultado.f4 = "$LMR_4 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_4)}";
		
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