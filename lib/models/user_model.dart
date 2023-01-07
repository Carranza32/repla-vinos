// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel? userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
	UserModel({
		this.codigo,
		this.usuario,
	});

	int? codigo;
	List<Usuario?>? usuario;

	factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
		codigo: json["codigo"],
		usuario: json["usuario"] == null ? [] : List<Usuario?>.from(json["usuario"]!.map((x) => Usuario.fromJson(x))),
	);

	Map<String, dynamic> toJson() => {
		"codigo": codigo,
		"usuario": usuario == null ? [] : List<dynamic>.from(usuario!.map((x) => x!.toJson())),
	};
}

class Usuario {
	Usuario({
		this.llaveApi,
		this.nombre,
		this.email,
	});

	String? llaveApi;
	String? nombre;
	String? email;

	factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
		llaveApi: json["llave_api"],
		nombre: json["nombre"],
		email: json["email"],
	);

	Map<String, dynamic> toJson() => {
		"llave_api": llaveApi,
		"nombre": nombre,
		"email": email,
	};
}
