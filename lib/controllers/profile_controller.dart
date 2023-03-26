import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';
import 'package:repla_vinos/providers/db_provider.dart';

class ProfileController extends GetxController {
	final nameTextController = TextEditingController();
	final emailTextController = TextEditingController();
	final passwordTextController = TextEditingController();
	final passwordRepeatTextController = TextEditingController();
	final GetStorage storage = GetStorage();
	final provider = ApiProvider();
	
	@override
	void onInit() async {
		try {
			Usuario? user = await DBProvider.db.getUser();

			if (user != null) {
				nameTextController.text = user.nombre!;
				emailTextController.text = user.email!;
			}

		} catch (e) {
		  	nameTextController.text = '';
			emailTextController.text = '';
		}

		super.onInit();
	}

	void updateProfile() async {
		try {
			var body = <String, dynamic>{};

			body['usuario[nombre]'] = nameTextController.text;
			body['usuario[email]'] = emailTextController.text;
			body['usuario[clave]'] = passwordTextController.text;

			final response = await provider.updateProfile(body);

			if (response == true) {
				Get.snackbar("Éxito", 'Perfil actualizado', snackPosition: SnackPosition.BOTTOM);
				// var data = GetStorage().read('user');
				// var user = (data is Usuario) ? data : Usuario.fromJson(data);

				Usuario? user = await DBProvider.db.getUser();
				user?.nombre = nameTextController.text;
				
				await DBProvider.db.updateUser(user!);

				Get.snackbar("Éxito", 'Perfil actualizado', snackPosition: SnackPosition.BOTTOM);
				passwordTextController.text = '';
				passwordRepeatTextController.text = '';
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}
		} catch (e) {
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}
}