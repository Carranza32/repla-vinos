import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repla_vinos/models/calculo_response_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';

class ApiProvider {
	final _baseUrl = "https://api.replavinos.cl/";

	Future<CalculoResponseModel?> calculo(Map<String, dynamic> body) async {
		final response = await http.post(
			Uri.parse('${_baseUrl}calculo'),
			body: body,
			headers: {
				HttpHeaders.authorizationHeader: GetStorage().read('user')['llave_api']
			}
    	);

		if (response.statusCode == 201) {
			return CalculoResponseModel.fromJson( jsonDecode(response.body) );
		}else{
			return null;
		}
	}

	Future<List<Plaguicida?>?> plaguicidas() async {
		final response = await http.post(
			Uri.parse('${_baseUrl}plaguicidas'),
			headers: {
				HttpHeaders.authorizationHeader: GetStorage().read('user')['llave_api']
			}
    	);

		if (response.statusCode != 201) {
			return null;
		}

		return PlaguicidasModel.fromJson( jsonDecode(response.body) ).plaguicidas;
	}
}