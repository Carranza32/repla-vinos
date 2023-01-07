// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/providers/auth_provider.dart';


class AuthController extends GetxController{
	final nameTextController = TextEditingController();
	final emailTextController = TextEditingController();
	final passwordTextController = TextEditingController();
	final GetStorage storage = GetStorage();
	final AuthProvider _authProvider = AuthProvider();

	@override
	void onReady() {
		emailTextController.text = "juan2@gmail.com";
		passwordTextController.text = "111111";
		// checkAuth();
		storage.erase();
		super.onReady();
	}

	void checkAuth() {
		try {
			var token = storage.read('user');

			if (token != null) {
				Get.offAllNamed("form_calculation");
			}else{
				Get.offAllNamed("login");
			}

		} catch (e) {
			print(e.toString());
		}
	}

	void login() async {
		//Loading
		Get.dialog(
			const Center(
				child: CircularProgressIndicator(),
			),
			barrierDismissible: false
		);

		var body = <String, dynamic>{};
		
		body['usuario[email]'] = emailTextController.text;
		body['usuario[clave]'] = passwordTextController.text;

		final response = await _authProvider.login(body);

		Get.back();

		if (response != null) {
			storage.write('user', response.usuario![0]);
			Get.offAllNamed("form_calculation");
		}else{
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}

	void register() async{
		//Loading
		Get.dialog(
			const Center(
				child: CircularProgressIndicator(),
			),
			barrierDismissible: false
		);

		var body = <String, dynamic>{};
		
		body['usuario[email]'] = nameTextController.text;
		body['usuario[email]'] = emailTextController.text;
		body['usuario[clave]'] = passwordTextController.text;

		final response = await _authProvider.signup(body);

		Get.back();

		if (response != null) {
			storage.write('user', response.usuario![0]);
			Get.offAllNamed("form_calculation");
		}else{
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}

	void resetPassword() async{
		// final response = await _authProvider.doPost("password/email", {
		// 	'email': emailTextController.text
		// });

		// if (response.isOk) {
		// 	Get.rawSnackbar(message: "good_job".tr);
		// }
	}

	@override
	void onClose() {
		nameTextController.dispose();
		emailTextController.dispose();
		passwordTextController.dispose();
		super.onClose();
	}
}