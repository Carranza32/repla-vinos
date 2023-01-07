import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repla_vinos/models/user_model.dart';

class AuthProvider {
	// final _baseUrl = "http://wood-chips.herokuapp.com/api/";
	final _baseUrl = "https://api.replavinos.cl/";

	Future<UserModel?> login(Map<String, dynamic> body) async {
		final response = await http.post(
			Uri.parse('${_baseUrl}inicio_sesion'),
			body: body,
    	);

		if (response.statusCode == 201) {
			return UserModel.fromJson( jsonDecode(response.body) );
		}else{
			return null;
		}
	}

	Future<UserModel?> signup(Map<String, dynamic> body) async {
		final response = await http.post(
			Uri.parse('${_baseUrl}usuario/registro'),
			body: body,
    	);

		if (response.statusCode == 201) {
			return UserModel.fromJson( jsonDecode(response.body) );
		}else{
			return null;
		}
	}

	Future<UserModel?> restartPassword(Map<String, dynamic> body) async {
		final response = await http.post(
			Uri.parse('${_baseUrl}recuperacion'),
			body: body,
    	);

		if (response.statusCode == 201) {
			return UserModel.fromJson( jsonDecode(response.body) );
		}else{
			return null;
		}
	}
}