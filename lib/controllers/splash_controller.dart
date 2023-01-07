import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
	@override
	void onReady() {
		try {
			var token = GetStorage().read('user');

			if (token != null) {
				Get.offAllNamed("form_calculation");
			}else{
				Get.offAllNamed("login");
			}
		} catch (e) {
			Get.offAllNamed("login");
		}
		
		super.onReady();
	}
}