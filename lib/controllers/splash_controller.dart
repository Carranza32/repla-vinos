import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
	@override
	void onReady() {
		try {
			String token = GetStorage().read('token');
			print(token);

			if (token != null) {
				print("Ya estas registrado");
				print(token);
				Get.offAllNamed("form_calculation");
			}else{
				Get.offAllNamed("login");
				print("No estas registrado");
			}
		} catch (e) {
			print(e.toString());
			Get.offAllNamed("login");
		}
		
		super.onReady();
	}
}