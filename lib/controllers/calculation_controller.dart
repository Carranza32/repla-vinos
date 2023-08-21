
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
			connection = false;

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

		final double _CONST_CM1 = 1.97832;
		final double _CONST_CM2 = 0.0018; 
		final double _CONST_CM3 = -0.14544;
		final double _CONST_RESGUARDO = 4;

		final double _CONST_05 = 0.5;
		final double _CONST_01 = 0.1;
		final double _CONST_005 = 0.05;
		final double _CONST_001 = 0.01;

		double diametro  = double.parse(form.datosDiametro);
		double dosis = double.parse(form.datosDosis);
		String vinificacion = form.datosVinificacion;

		double cm = _CONST_CM1 + (_CONST_CM2 * dosis) + (_CONST_CM3 * diametro);
		double k_utilizado = (diametro <= 3 ? k/0.4 :( diametro < 4.5 ? k/0.7 : k));
			
		double dias_05 = (log((_CONST_05/(vinificacion == 'TINTO' ? ftt : ftb))/cm))/-k_utilizado;
		double dias_01 = (log((_CONST_01/(vinificacion == 'TINTO' ? ftt : ftb))/cm))/-k_utilizado;
		double dias_005 = (log((_CONST_005/(vinificacion == 'TINTO' ? ftt : ftb))/cm))/-k_utilizado;
		double dias_001 = (log((_CONST_001/(vinificacion == 'TINTO' ? ftt : ftb))/cm))/-k_utilizado;

		dias_05 = (dias_05 < _CONST_RESGUARDO ? _CONST_RESGUARDO : dias_05);
		dias_01 = (dias_01 < _CONST_RESGUARDO ? _CONST_RESGUARDO : dias_01);
		dias_005 = (dias_005 < _CONST_RESGUARDO ? _CONST_RESGUARDO : dias_005);
		dias_001 = (dias_001 < _CONST_RESGUARDO ? _CONST_RESGUARDO : dias_001);

		List<String> dateSplit = form.datosFechaAplicacion.split('/');
		String day = dateSplit[2].toString();
		String month = dateSplit[1].toString(); 
		String year = dateSplit[0].toString();

		DateTime appdate = DateTime.parse('$year-$month-$day');
		DateTime fecha_1 = appdate.add(Duration(days: dias_05.round()));
		DateTime fecha_2 = appdate.add(Duration(days: dias_01.round()));
		DateTime fecha_3 = appdate.add(Duration(days: dias_005.round()));
		DateTime fecha_4 = appdate.add(Duration(days: dias_001.round()));


    //Aqui va la respuesta
		var resultado = Resultado();

		resultado.titulo = plaguicida.plaguicida;
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

		resultado.f1 = "$_CONST_05 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_1)}";
		resultado.f2 = "$_CONST_01 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_2)}";
		resultado.f3 = "$_CONST_005 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_3)}";
		resultado.f4 = "$_CONST_001 (mg/kg) ${DateFormat('dd-MM-yyyy').format(fecha_4)}";
		
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

			DateTime lastUpdate;
			int days;

			List<Plaguicida>? resp = await DBProvider.db.getAllPlagicidas();

			if (resp == null) {
				getPlaguicidasFromInternet();
			}

			try {
				lastUpdate = await DBProvider.db.getLastPlaguicidasUpdated();
				days = DateTime.now().difference(lastUpdate).inDays;
				print("Dias desde ultima actualizacion: $days");
			} catch (e) {
				days = 11;
				print(e);
			}

			if ( days > 10 ) {
			  	getPlaguicidasFromInternet();
			}else{
				List<Plaguicida>? resp = await DBProvider.db.getAllPlagicidas();

				if (resp != null) {
					print("Plagicidas Desde SQLite");
					plaguicidas.clear();

					for (var element in resp) {
						plaguicidas.add(element);
					}
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

	getPlaguicidasFromInternet() async {
		final response = await provider.plaguicidas();

		if (response != null) {
			print("Plagicidas Desde Internet");
			plaguicidas.clear();
			await DBProvider.db.deleteAllPlagicidas();

			for (var element in response) {
				plaguicidas.add(element!);
				await DBProvider.db.insertPlagicida(element);
			}

			await DBProvider.db.updateLastPlaguicidasUpdated();
		}
	}

	@override
	void onClose() {}
}