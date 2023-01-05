import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/providers/auth_provider.dart';

class RegisterController extends GetxController {
	AuthProvider _authProvider = AuthProvider();
	late TextEditingController nameTextController;
	late TextEditingController emailTextController;
	late TextEditingController passwordTextController;

	@override
	void onInit() {
		nameTextController = TextEditingController();
		emailTextController = TextEditingController();
		passwordTextController = TextEditingController();
		super.onInit();
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

	@override
	void onClose() {
		nameTextController.dispose();
		emailTextController.dispose();
		passwordTextController.dispose();
		super.onClose();
	}
}