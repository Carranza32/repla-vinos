import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repla_vinos/models/calculo_response_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/models/slider_model.dart';
import 'package:repla_vinos/models/user_model.dart';

class ApiProvider {
	final _baseUrl = "https://api.replavinos.cl/";

	Future<CalculoResponseModel?> calculo(Map<String, dynamic> body) async {
		Usuario user = GetStorage().read('user');

		final response = await http.post(
			Uri.parse('${_baseUrl}calculo'),
			body: body,
			headers: {
				HttpHeaders.authorizationHeader: user.llaveApi ?? ''
			}
    	);

		if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
			return CalculoResponseModel.fromJson( jsonDecode(response.body) );
		}else{
			return null;
		}
	}

	Future<List<Plaguicida?>?> plaguicidas() async {
		try {
			Usuario user = GetStorage().read('user');

			final response = await http.post(
				Uri.parse('${_baseUrl}plaguicidas'),
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode != HttpStatus.created) {
				return null;
			}

			return PlaguicidasModel.fromJson( jsonDecode(response.body) ).plaguicidas;
		} catch (e) {
		  return null;
		}
	}

	Future<List<SliderObj?>?> getSliders() async {
		try {
			Usuario user = GetStorage().read('user');

			final response = await http.post(
				Uri.parse('${_baseUrl}slider'),
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode != HttpStatus.created) {
				return null;
			}

			return SliderModel.fromJson( jsonDecode(response.body) ).slider;
		} catch (e) {
		  return null;
		}
	}

	Future<bool?> sendEmails(Map<String, dynamic> body) async {
		try {
			Usuario user = GetStorage().read('user');

			final response = await http.post(
				Uri.parse('${_baseUrl}resultados'),
				body: body,
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode != HttpStatus.created) {
				return false;
			}

			return true;
		} catch (e) {
		  return false;
		}
	}

	Future<bool?> updateProfile(Map<String, dynamic> body) async {
		try {
			Usuario user = GetStorage().read('user');

			final response = await http.post(
				Uri.parse('${_baseUrl}usuario'),
				body: body,
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode != HttpStatus.created) {
				return false;
			}

			return true;
		} catch (e) {
		  return false;
		}
	}
}