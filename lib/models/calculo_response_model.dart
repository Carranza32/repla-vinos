// To parse this JSON data, do
//
//     final calculoResponseModel = calculoResponseModelFromJson(jsonString);

import 'dart:convert';

CalculoResponseModel? calculoResponseModelFromJson(String str) => CalculoResponseModel.fromJson(json.decode(str));

String calculoResponseModelToJson(CalculoResponseModel? data) => json.encode(data!.toJson());

class CalculoResponseModel {
	CalculoResponseModel({
		this.codigo,
		this.mensaje,
		this.resultado,
	});

	int? codigo;
	String? mensaje;
	Resultado? resultado;

	factory CalculoResponseModel.fromJson(Map<String, dynamic> json) => CalculoResponseModel(
		codigo: json["codigo"],
		mensaje: json["mensaje"],
		resultado: Resultado.fromJson(json["resultado"]),
	);

	Map<String, dynamic> toJson() => {
		"codigo": codigo,
		"mensaje": mensaje,
		"resultado": resultado!.toJson(),
	};
}

class Resultado {
	Resultado({
		this.titulo,
		this.txtBq1,
		this.txtBq2,
		this.f1,
		this.f2,
		this.f3,
		this.f4,
		this.pie,
	});

	String? titulo;
	List<String?>? txtBq1;
	List<String?>? txtBq2;
	String? f1;
	String? f2;
	String? f3;
	String? f4;
	String? pie;

	factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
		titulo: json["titulo"],
		txtBq1: json["txt_bq1"] == null ? [] : List<String?>.from(json["txt_bq1"]!.map((x) => x)),
		txtBq2: json["txt_bq2"] == null ? [] : List<String?>.from(json["txt_bq2"]!.map((x) => x)),
		f1: json["f1"],
		f2: json["f2"],
		f3: json["f3"],
		f4: json["f4"],
		pie: json["pie"],
	);

	Map<String, dynamic> toJson() => {
		"titulo": titulo,
		"txt_bq1": txtBq1 == null ? [] : List<dynamic>.from(txtBq1!.map((x) => x)),
		"txt_bq2": txtBq2 == null ? [] : List<dynamic>.from(txtBq2!.map((x) => x)),
		"f1": f1,
		"f2": f2,
		"f3": f3,
		"f4": f4,
		"pie": pie,
	};
}
