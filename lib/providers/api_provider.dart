import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repla_vinos/models/calculo_response_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
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
	}
}