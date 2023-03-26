// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
	FormModel({
		required this.datosVinificacion,
		required this.datosDiametro,
		required this.datosPlaguicida,
		required this.datosDosis,
		required this.datosFechaAplicacion,
		required this.datosSo,
	});

	String datosVinificacion;
	String datosDiametro;
	String datosPlaguicida;
	String datosDosis;
	String datosFechaAplicacion;
	String datosSo;

	factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
		datosVinificacion: json["datos[vinificacion]"],
		datosDiametro: json["datos[diametro]"],
		datosPlaguicida: json["datos[plaguicida]"],
		datosDosis: json["datos[dosis]"],
		datosFechaAplicacion: json["datos[fecha_aplicacion]"],
		datosSo: json["datos[so]"],
	);

	Map<String, dynamic> toJson() => {
		"datos[vinificacion]": datosVinificacion,
		"datos[diametro]": datosDiametro,
		"datos[plaguicida]": datosPlaguicida,
		"datos[dosis]": datosDosis,
		"datos[fecha_aplicacion]": datosFechaAplicacion,
		"datos[so]": datosSo,
	};

	Map<String, dynamic> toMapForDb() => {
		"vinificacion": datosVinificacion,
		"diametro": datosDiametro,
		"plaguicida": datosPlaguicida,
		"dosis": datosDosis,
		"fechaAplicacion": datosFechaAplicacion,
		"so": datosSo,
	};
}
