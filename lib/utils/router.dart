import 'package:get/get.dart';
import 'package:repla_vinos/screens/index.dart';

class Routes {
	static final route = [
		GetPage(
			name: '/splash',
			page: () => const SplashScreen(),
		),
		GetPage(
			name: '/login',
			page: () => LoginScreen(),
		),
		GetPage(
			name: '/signup',
			page: () => SignUpScreen(),
		),
		GetPage(
			name: '/form_calculation',
			page: () => const FormCalculationScreen(),
		),
	];
}