import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repla_vinos/utils/messages_translations.dart';
import 'package:repla_vinos/utils/router.dart';

void main() async {
  	await GetStorage.init();
  	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return GetMaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Repla vinos',
			getPages: Routes.route,
			initialRoute: 'splash',
			locale: const Locale('es', 'ES'),
			translations: LanguageTranslations(),
			fallbackLocale: const Locale('es'),
			theme: ThemeData(
				useMaterial3: true,
				// primaryColor: const Color(0xff3c37ff),
				primaryColor: const Color(0xffa9fd85),
				textTheme: const TextTheme(
					bodyText1: TextStyle(
						fontSize: 18,
						color: Color(0xff111b31),
					),
				),
			)
		);
	}
}