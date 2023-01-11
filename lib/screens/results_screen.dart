// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/constants.dart';
import 'package:repla_vinos/controllers/result_controller.dart';
import 'package:repla_vinos/models/calculo_response_model.dart';

class ResultScreen extends StatelessWidget {
	ResultScreen({super.key});
	final ResultController resultController = Get.put(ResultController());

	// Resultado resultado = Get.arguments[0]['resultado'];

	Resultado resultado = Resultado(
		titulo: 'Azoxystrobin',
		txtBq1: [
			"Nivel aproximado de residuo en vino ",
			"TINTO",
			" en base a fecha de cosecha estimada. "
		],
		txtBq2: [
			"Resultados obtenidos en base a la fecha de aplicación ",
			"07/01/2023",
			", uva ",
			"5(mm)",
			" y dosis ",
			"230(g activo/ha)."
		],
		f1: '0.1 (mg/kg) 01-01-1970',
		f2: '0.05 (mg/kg) 01-01-1970',
		f3: '0.01 (mg/kg) 01-01-1970',
		f4: '0.04 (mg/kg) 01-01-1970',
		pie: 'Las fechas de cosecha son referenciales y han sido obtenidas a partir de curvas de disperción en campo y estudios de traspaso de residuos de poluguicidas en el proceso de vinificación.',
	);	

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
				alignment: Alignment.topCenter,
				padding: const EdgeInsets.all(20),				
				child: Container(
					width: MediaQuery.of(context).size.width * 0.70,
					padding: const EdgeInsets.all(25),
					decoration: const BoxDecoration(
						color: Colors.white,
						borderRadius: BorderRadius.all(Radius.circular(15)),
						boxShadow: [
							BoxShadow(
								color: Colors.black12,
								blurRadius: 15,
								spreadRadius: 0,
								offset: Offset(0, 10)
							)
						]
					),
				  	child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisAlignment: MainAxisAlignment.center,
						mainAxisSize: MainAxisSize.min,
						children: [
							Text(resultado.titulo ?? 'No hay resultados', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
							const SizedBox(height: 25),

							RichText(
								text: TextSpan(
									children: [
										TextSpan(text: resultado.txtBq1![0] ?? '', style: Theme.of(context).textTheme.bodyMedium),
										TextSpan(text: resultado.txtBq1![1] ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
										TextSpan(text: resultado.txtBq1![2] ?? '', style: Theme.of(context).textTheme.bodyMedium),
									]
								),
							),						
							const SizedBox(height: 25),

							RichText(
								text: TextSpan(
									children: [
										TextSpan(text: resultado.txtBq2![0] ?? '', style: Theme.of(context).textTheme.bodyMedium),
										TextSpan(text: resultado.txtBq2![1] ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
										TextSpan(text: resultado.txtBq2![2] ?? '', style: Theme.of(context).textTheme.bodyMedium),
										TextSpan(text: resultado.txtBq2![3] ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
										TextSpan(text: resultado.txtBq2![4] ?? '', style: Theme.of(context).textTheme.bodyMedium),
										TextSpan(text: resultado.txtBq2![5] ?? '', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
									]
								),
							),	
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
							Container(
								width: double.infinity,
								height: 55,
								padding: const EdgeInsets.symmetric(horizontal: 35),
								child: ElevatedButton(
									style: ElevatedButton.styleFrom(
										backgroundColor: const Color(0xffa3fb82),
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(15),
										),
									),
									onPressed: () {
										Get.defaultDialog(
											title: 'Enviar resultados',
											content: Column(
												children: [
													TextField(
														keyboardType: TextInputType.emailAddress,
														style: kTextFormFieldStyle(),
														decoration: authFormFieldStyle().copyWith(
															prefixIcon: const Icon(Icons.person, color: Color(0xff4bbf78),),
															labelText: 'email'.tr,
															hintText: 'Indique el email, si agrega varios, sepárelos con una coma (,)',
															helperText: 'Indique el email, si agrega varios, sepárelos con una coma (,)',
														),
														controller: resultController.emailTextController,
													),

													const SizedBox(
														height: 30.0,
													),
													
													ElevatedButton(
														style: ElevatedButton.styleFrom(
															backgroundColor: const Color(0xffa3fb82),
															shape: RoundedRectangleBorder(
																borderRadius: BorderRadius.circular(15),
															),
														),
														onPressed: () {
															resultController.sendEmail();
														},
														child: const Text('Enviar',
															style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31)),
														),
													)
												],
											)
										);
									},
									child: Text('send_email'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
								),
							),
						],
				  	),
				),
			),
		);
	}
}