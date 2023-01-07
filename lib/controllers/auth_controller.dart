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
		checkAuth();
		super.onReady();
	}

	void checkAuth() {
		try {
			String token = storage.read('token');

			if (token != null) {
				print("Ya estas registrado");
				print(token);
				Get.offAllNamed("form_calculation");
			}else{
				print("No estas registrado");
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

		final response = await _authProvider.doPost("inicio_sesion", {
			'usuario[email]': emailTextController.text,
			'usuario[clave]': passwordTextController.text
		});

		Get.back();

		print(response.body);

		if (response.isOk && response.body["success"]) {
			// storage.write('token', response.body["token"]);
			// Get.offAllNamed("form_calculation");
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

		final response = await _authProvider.doPost("register", {
			'name': nameTextController.text,
			'email': emailTextController.text,
			'password': passwordTextController.text,
		});

		Get.back();

		if (response.isOk && response.body["success"]) {
			print(response.body["token"]);
			GetStorage().write('token', response.body["token"]);
			Get.offAllNamed("form_calculation");
		}else{
			Get.snackbar("Error", "wrong_try_again".tr, snackPosition: SnackPosition.BOTTOM);
		}
	}

	void resetPassword() async{
		final response = await _authProvider.doPost("password/email", {
			'email': emailTextController.text
		});

		if (response.isOk) {
			Get.rawSnackbar(message: "good_job".tr);
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