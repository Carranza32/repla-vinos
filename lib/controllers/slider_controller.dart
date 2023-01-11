// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:repla_vinos/models/slider_model.dart';
import 'package:repla_vinos/providers/api_provider.dart';

class SliderController extends GetxController {
	final provider = ApiProvider();
	List<SliderObj?>? sliders = [];
	var postLoading = true.obs;
	
	@override
	void onInit() async {
		postLoading.value = true;
		final response = await provider.getSliders();

		if (response != null) {
			sliders!.clear();

			for (var element in response) {
				sliders!.add(element);
			}
		}

		postLoading.value = false;
	  	super.onInit();
	}

	List<PageViewModel> getPages(){
		List<PageViewModel> lista = [];
		var otra = sliders;

		for (var element in sliders!) {
			lista.add(
				PageViewModel(
					pageColor: const Color(0xFF03A9F4),
					iconImageAssetPath: element?.imagen ?? '',
					title: Text(element?.titulo ?? ''),
					body: Text(element?.texto ?? ''),
					textStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
					mainImage: FadeInImage.assetNetwork(
						image: element?.imagen ?? '',
						placeholder: 'assets/no-image.png',
						height: 285.0,
						width: 285.0,
						alignment: Alignment.center,
					)
				),
			);
		}

		update();

		return lista;
	}
}