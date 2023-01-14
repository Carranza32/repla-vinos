import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/models/user_model.dart';

class SplashController extends GetxController {
	@override
	void onReady() {
		try {
			var data = GetStorage().read('user');
			Usuario user = Usuario();

			if (data != null) {
			  	user = (data is Usuario) ? data : Usuario.fromJson(data);
			}

			var slider = GetStorage().read('slider_showed');

			if (slider == false || slider == null) {
				GetStorage().write('slider_showed', true);

			  	Get.offAllNamed('intro');
				return;
			}

			if (user.llaveApi != null) {
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