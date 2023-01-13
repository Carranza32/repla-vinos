// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:repla_vinos/models/user_model.dart';

RegisterResponseModel? registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel? data) => json.encode(data!.toJson());

class RegisterResponseModel {
	RegisterResponseModel({
		this.codigo,
		this.mensaje,
		this.usuario,
	});

	int? codigo;
	String? mensaje;
	Usuario? usuario;

	factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
		codigo: json["codigo"],
		mensaje: json["mensaje"],
		usuario: Usuario.fromJson(json["usuario"]),
	);

	Map<String, dynamic> toJson() => {
		"codigo": codigo,
		"mensaje": mensaje,
		"usuario": usuario!.toJson(),
	};
}
