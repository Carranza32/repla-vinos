// To parse this JSON data, do
//
//     final plaguicidasModel = plaguicidasModelFromJson(jsonString);

import 'dart:convert';

PlaguicidasModel? plaguicidasModelFromJson(String str) => PlaguicidasModel.fromJson(json.decode(str));

String plaguicidasModelToJson(PlaguicidasModel? data) => json.encode(data!.toJson());

class PlaguicidasModel {
	PlaguicidasModel({
		this.codigo,
		this.plaguicidas,
	});

	int? codigo;
	List<Plaguicida?>? plaguicidas;

	factory PlaguicidasModel.fromJson(Map<String, dynamic> json) => PlaguicidasModel(
		codigo: json["codigo"],
		plaguicidas: json["plaguicidas"] == null ? [] : List<Plaguicida?>.from(json["plaguicidas"]!.map((x) => Plaguicida.fromJson(x))),
	);

	Map<String, dynamic> toJson() => {
		"codigo": codigo,
		"plaguicidas": plaguicidas == null ? [] : List<dynamic>.from(plaguicidas!.map((x) => x!.toJson())),
	};
}

class Plaguicida {
	Plaguicida({
		this.id,
		this.plaguicida,
		this.k,
		this.ftt,
		this.ftb,
	});

	String? id;
	String? plaguicida;
	String? k;
	String? ftt;
	String? ftb;

	factory Plaguicida.fromJson(Map<String, dynamic> json) => Plaguicida(
		id: json["id"],
		plaguicida: json["plaguicida"],
		k: json["k"],
		ftt: json["ftt"],
		ftb: json["ftb"],
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"plaguicida": plaguicida,
		"k": k,
		"ftt": ftt,
		"ftb": ftb,
	};

	Map<String, dynamic> toMapForDb() => {
		"id": id,
		"plaguicida": plaguicida,
		"k": k,
		"ftt": ftt,
		"ftb": ftb,
	};

	@override
	String toString() => plaguicida!;

	@override
	operator == (other) => other is Plaguicida && other.id == id;

	@override
	int get hashCode => id.hashCode^plaguicida.hashCode^id.hashCode;
}
