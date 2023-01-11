
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';

class ResultController extends GetxController {
	final emailTextController = TextEditingController();
	final provider = ApiProvider();
	
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
		var body = <String, dynamic>{};
		body['datos[emails]'] = emailTextController.text;

		final response = await provider.sendEmails(body);

		Get.back();

		if (response == true) {			
			Get.snackbar("Éxito", 'Correo enviado', snackPosition: SnackPosition.BOTTOM);
		}else{
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}

		
	}
}