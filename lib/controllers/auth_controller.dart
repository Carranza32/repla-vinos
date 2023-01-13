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
			if (response.usuario!.isNotEmpty) {
			   storage.write('user', response.usuario![0]);
				Get.offAllNamed("form_calculation");
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}
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
		
		body['usuario[nombre]'] = nameTextController.text;
		body['usuario[email]'] = emailTextController.text;
		body['usuario[clave]'] = passwordTextController.text;

		final response = await _authProvider.signup(body);

		Get.back();

		if (response != null) {
			if (response.usuario != null) {
			   storage.write('user', response.usuario); 
				Get.offAllNamed("form_calculation");
			}else{
				Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
			}			
		}else{
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}

	void resetPassword() async{
		var body = <String, dynamic>{};
		
		body['usuario[email]'] = emailTextController.text;

		final response = await _authProvider.restartPassword(body);

		if (response != true) {
			Get.rawSnackbar(message: "wrong_try_again".tr);
			// Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);		
		}else{
			
		}
	}

	@override
	void onClose() {
		nameTextController.dispose();
		emailTextController.dispose();
		passwordTextController.dispose();
		super.onClose();
	}
}