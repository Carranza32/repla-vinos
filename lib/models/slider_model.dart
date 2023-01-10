// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel? sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel? data) => json.encode(data!.toJson());

class SliderModel {
	SliderModel({
		this.codigo,
		this.mensaje,
		this.slider,
	});

	int? codigo;
	String? mensaje;
	List<Slider?>? slider;

	factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
		codigo: json["codigo"],
		mensaje: json["mensaje"],
		slider: json["slider"] == null ? [] : List<Slider?>.from(json["slider"]!.map((x) => Slider.fromJson(x))),
	);

	Map<String, dynamic> toJson() => {
		"codigo": codigo,
		"mensaje": mensaje,
		"slider": slider == null ? [] : List<dynamic>.from(slider!.map((x) => x!.toJson())),
	};
}

class Slider {
	Slider({
		this.id,
		this.titulo,
		this.imagen,
		this.texto,
	});

	String? id;
	String? titulo;
	String? imagen;
	String? texto;

	factory Slider.fromJson(Map<String, dynamic> json) => Slider(
		id: json["id"],
		titulo: json["titulo"],
		imagen: json["imagen"],
		texto: json["texto"],
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"titulo": titulo,
		"imagen": imagen,
		"texto": texto,
	};
}