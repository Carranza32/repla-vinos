
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';

import '../models/calculo_response_model.dart';

class ResultController extends GetxController {
	final emailTextController = TextEditingController();
	final provider = ApiProvider();
	Resultado resultado = Get.arguments[0]['resultado'];
	
	@override
	void onReady() {
		try {
		  	Usuario user = GetStorage().read('user');

			emailTextController.text = user.email!;
		} catch (e) {
		  	emailTextController.text = '';
		}

		super.onReady();
	}

	void sendEmail() async{	
		try {
			var body = <String, dynamic>{};
			var f1 = resultado.f1!.split(" ");
			var f2 = resultado.f2!.split(" ");
			var f3 = resultado.f3!.split(" ");
			var f4 = resultado.f4!.split(" ");
			var date = DateFormat('dd/MM/yyyy').parse(resultado.txtBq2![1] ?? '');

			var dt1 = DateFormat('dd-MM-yyyy').parse(f1[2]);
			var dt2 = DateFormat('dd-MM-yyyy').parse(f2[2]);
			var dt3 = DateFormat('dd-MM-yyyy').parse(f3[2]);
			var dt4 = DateFormat('dd-MM-yyyy').parse(f4[2]);
			
			body['usuario[emails]'] = emailTextController.text;
			body['usuario[plaguicida]'] = resultado.titulo;
			body['usuario[titulo]'] = "${resultado.txtBq1![0]} ${resultado.txtBq1![1]} ${resultado.txtBq1![2]}";
			body['usuario[mensaje]'] = "${resultado.txtBq2![0]} ${resultado.txtBq2![1]}";

			body['usuario[resultado1]'] = f1[2];
			body['usuario[resultado2]'] = f2[2];
			body['usuario[resultado3]'] = f3[2];
			body['usuario[resultado4]'] = f4[2];

			body['usuario[resguardo1]'] = dt1.difference(date).inDays.toString();
			body['usuario[resguardo2]'] = dt2.difference(date).inDays.toString();
			body['usuario[resguardo3]'] = dt3.difference(date).inDays.toString();
			body['usuario[resguardo4]'] = dt4.difference(date).inDays.toString();

			final response = await provider.sendEmails(body);

			Get.back();

			if (response == true) {			
				Get.snackbar("Éxito", 'Correo enviado', snackPosition: SnackPosition.BOTTOM);
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}
		} catch (e) {
		  	Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}
}