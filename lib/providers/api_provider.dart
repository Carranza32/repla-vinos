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
		var data = GetStorage().read('user');
		var user = (data is Usuario) ? data : Usuario.fromJson(data);

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
			var data = GetStorage().read('user');
			var user = (data is Usuario) ? data : Usuario.fromJson(data);

			final response = await http.post(
				Uri.parse('${_baseUrl}plaguicidas'),
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
				return PlaguicidasModel.fromJson( jsonDecode(response.body) ).plaguicidas;
			}else{
				return null;
			}
		} catch (e) {
		  return null;
		}
	}

	Future<List<SliderObj?>?> getSliders() async {
		try {
			var data = GetStorage().read('user');
			var user = (data is Usuario) ? data : Usuario.fromJson(data);

			final response = await http.post(
				Uri.parse('${_baseUrl}slider'),
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
				return SliderModel.fromJson( jsonDecode(response.body) ).slider;
			}else{
				return null;
			}
		} catch (e) {
		  return null;
		}
	}

	Future<bool?> sendEmails(Map<String, dynamic> body) async {
		try {
			var data = GetStorage().read('user');
			var user = (data is Usuario) ? data : Usuario.fromJson(data);

			final response = await http.post(
				Uri.parse('${_baseUrl}resultados'),
				body: body,
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
				return true;
			}else{
				return false;
			}			
		} catch (e) {
		  return false;
		}
	}

	Future<bool?> updateProfile(Map<String, dynamic> body) async {
		try {
			var data = GetStorage().read('user');
			var user = (data is Usuario) ? data : Usuario.fromJson(data);

			final response = await http.post(
				Uri.parse('${_baseUrl}usuario'),
				body: body, 
				headers: {
					HttpHeaders.authorizationHeader: user.llaveApi ?? ''
				}
			);

			if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
				return true;
			}else{
				return false;
			}	
		} catch (e) {
		  return false;
		}
	}
}