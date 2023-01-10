// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/models/calculo_response_model.dart';

class ResultScreen extends StatelessWidget {
	ResultScreen({super.key});
	Resultado resultado = Get.arguments[0]['resultado'];

	// Resultado resultado = Resultado(
	// 	titulo: 'Azoxystrobin',
	// 	txtBq1: 'Nivel aproximado de residuo en vino [TINTO] en base a fecha de cosecha estimada.',
	// 	txtBq2: 'Resultados obtenidos en base a la fecha de aplicación [07/01/2023], uva [5(mm)] y dosis [230(g activo/ha)].',
	// 	f1: '0.1 (mg/kg) 01-01-1970',
	// 	f2: '0.05 (mg/kg) 01-01-1970',
	// 	f3: '0.01 (mg/kg) 01-01-1970',
	// 	f4: '0.04 (mg/kg) 01-01-1970',
	// 	pie: 'Las fechas de cosecha son referenciales y han sido obtenidas a partir de curvas de disperción en campo y estudios de traspaso de residuos de poluguicidas en el proceso de vinificación.',
	// );	

	@override
	Widget build(BuildContext context) {
		// ignore: unnecessary_null_comparison
		if(resultado == null){
			Get.toNamed("form_calculation");
		}

		return Scaffold(
			appBar: AppBar(
				backgroundColor: const Color(0xff11ab6a),
				title: const Text('Resultados'),
			),
			body: Container(
				alignment: Alignment.center,
				padding: const EdgeInsets.all(20),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Text(resultado.titulo ?? 'No hay resultados', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
						const SizedBox(height: 25),

						RichText(
							text: TextSpan(
								children: [
									TextSpan(text: resultado.txtBq1 ?? '', style: Theme.of(context).textTheme.bodyMedium),
								]
							),
						),						
						const SizedBox(height: 25),

						Text(resultado.txtBq2 ?? '', style: Theme.of(context).textTheme.bodyMedium),
						const SizedBox(height: 25),

						Text(resultado.f1 ?? '', style: Theme.of(context).textTheme.bodyMedium),
						const SizedBox(height: 10),

						Text(resultado.f2 ?? '', style: Theme.of(context).textTheme.bodyMedium),
						const SizedBox(height: 10),

						Text(resultado.f3 ?? '', style: Theme.of(context).textTheme.bodyMedium),
						const SizedBox(height: 10),

						Text(resultado.f4 ?? '', style: Theme.of(context).textTheme.bodyMedium),
						const SizedBox(height: 10),

						const SizedBox(height: 25),
						Text(resultado.pie ?? '', style: Theme.of(context).textTheme.bodyMedium),

						const SizedBox(height: 25),
						SizedBox(
							width: double.infinity,
							height: 55,
							child: ElevatedButton(
								style: ElevatedButton.styleFrom(
									backgroundColor: const Color(0xffa3fb82),
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(15),
									),
								),
								onPressed: () {
								},
								child: Text('send_email'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
							),
						),
					],
				),
			),
		);
	}
}