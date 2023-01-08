import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:repla_vinos/constants.dart';
import 'package:repla_vinos/controllers/calculation_controller.dart';
import 'package:select_dialog/select_dialog.dart';


import '../models/plaguidas_model.dart';

class FormCalculationScreen extends StatelessWidget {
	final CalculationController calculationController = Get.put(CalculationController());
  	final _formKey = GlobalKey<FormState>();

  	FormCalculationScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;

		return SafeArea(
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: const Color(0xff11ab6a),
				),
				drawer: _drawer(context),
				body: SingleChildScrollView(
					child: Form(
						key: _formKey,
						child: Column(
							children: [
								_header(context, textTheme, calculationController),							
								SizedBox(
								width: MediaQuery.of(context).size.width * 0.93,
									child: ListView(
								primary: false,
								padding: const EdgeInsets.all(20),
								shrinkWrap: true,
								children: [
									const SizedBox(height: 3),

									Text('Fecha Aplicacion', style: textTheme.headline6),

									const SizedBox(height: 15),

									GestureDetector(
										child: TextFormField(
											controller: calculationController.fechaTextController,
											enabled: false,
											decoration: formFieldStyle().copyWith(
												labelText: 'Fecha',											
											),
											validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
										),
										onTap: () {
											showDatePicker(
												context: context,
												initialDate: calculationController.fechaTextController.text.isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(calculationController.fechaTextController.text),
												firstDate: DateTime(2000),
												lastDate: DateTime(2100),
												cancelText: 'Cancelar',
												builder: (context, child) {
													return Theme(
														data: Theme.of(context).copyWith(
															colorScheme: const ColorScheme.light(
																primary: Color(0xff11ab6a),
															),
															buttonTheme: const ButtonThemeData(
																textTheme: ButtonTextTheme.primary,
															),
														),
														child: child!,
													);
												},
											).then((date) {
												if (date != null) {
													calculationController.fechaTextController.text = DateFormat('dd/MM/yyyy').format(date);
												}
											});
										},
									),

									const SizedBox(height: 20),

									Text('Diametro uva (mm)', style: textTheme.headline6),

									const SizedBox(height: 15),

									TextFormField(
										controller: calculationController.diametroTextController,
										decoration: formFieldStyle().copyWith(
											labelText: 'Diametro',											
										),
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}'))],
										validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
									),

									const SizedBox(height: 20),

									Text('Plaguicida', style: textTheme.headline6),

									const SizedBox(height: 20),

									GestureDetector(
										child: TextFormField(
											controller: calculationController.plaguicidaTextController,
											enabled: false,
											decoration: formFieldStyle().copyWith(
												labelText: 'Plaguicida',											
											),
											validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
										),
										onTap: () {
											SelectDialog.showModal<Plaguicida>(
												context,
												label: 'Plaguicida',
												searchHint: 'Buscar plaguicida',
												items: calculationController.plaguicidas,
												selectedValue: calculationController.selectedPlaguicida,
												onChange: (Plaguicida selected) {
													calculationController.selectedPlaguicida = selected;

													calculationController.plaguicidaTextController.text = selected.plaguicida!;
												},
											);
										},
									),

									const SizedBox(height: 20),

									Text('Dosis (g activo/ha)', style: textTheme.headline6),

									const SizedBox(height: 15),

									TextFormField(
										controller: calculationController.dosisTextController,
										decoration: formFieldStyle().copyWith(
											labelText: 'Dosis',											
										),
										validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}'))],
									),

									const SizedBox(height: 15),

									_formButton(context),

									const SizedBox(height: 25),
								],
							),
								),
							],
						),
					),
				)
			),
		);
	}

	Widget _header(context, textTheme, CalculationController calculationController) {

		return Stack(
			clipBehavior: Clip.none,
			children: [
				Container(
					width: MediaQuery.of(context).size.width,
					height: 145,
					decoration: const BoxDecoration(
						color: Color(0xff11ab6a),
						borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
					),
				),

				Container(
					alignment: Alignment.center,
					child: Text('Registro de aplicación', style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)),
				),

				Center(
				  child: Container(
					alignment: Alignment.center,
					margin: const EdgeInsets.only(top: 75),
				  	width: MediaQuery.of(context).size.width * 0.93,
				  	padding: const EdgeInsets.all(15),
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
				  		children: [
				  			Text('Vinificación', style: textTheme.headline6),

				  			const SizedBox(height: 20),

				  			CustomSlidingSegmentedControl(
								controller: calculationController.vinoTextController,
				  				isStretch: true,
				  				initialValue: 'tinto',
				  				children: const {
				  					'tinto': Text('Tinto', style: TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16) ),
				  					'blanco': Text('Blanco', style: TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16)),
				  				},
				  				duration: const Duration(milliseconds: 300),
				  				curve: Curves.easeInToLinear,
				  				onValueChanged: (v) {
				  					calculationController.vinoTextController.value = v;
				  				},
				  				innerPadding: const EdgeInsets.all(3),
				  				decoration: BoxDecoration(
				  					color: Colors.grey.withOpacity(.2),
				  					borderRadius: BorderRadius.circular(10),
				  				),
				  				thumbDecoration: BoxDecoration(
				  					color: const Color(0xffa9fd85),
				  					borderRadius: BorderRadius.circular(10),
				  					boxShadow: [
				  						BoxShadow(
				  							color: Colors.black.withOpacity(.1),
				  							blurRadius: 15,
				  							spreadRadius: -3,
				  							offset: const Offset(
				  								0.0,
				  								10.0,
				  							),
				  						),
				  					],
				  				),
				  			),
				  		],
				  	),
				  ),
				),
			],

		);
	}

	// form Button
	Widget _formButton(context) {
		return InkWell(
			onTap: () {
				if (_formKey.currentState!.validate()) {
					calculationController.postCalculate();
				}
			},			
			child: Container(
				height: 60,
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						colors: [
						Color.fromRGBO(1, 183, 97, 1),
						Color.fromRGBO(1, 183, 97, 1),
						],
						begin: Alignment.centerLeft,
						end: Alignment.centerRight,
					),
					borderRadius: BorderRadius.all(
						Radius.circular(25.0),
					),
					boxShadow: [
						BoxShadow(
						color: Color.fromRGBO(1, 183, 97, 0.5),
						spreadRadius: 1,
						blurRadius: 15,
						offset: Offset(0, 5),
						)
					]
				),
				child: const Center(
					child: Text('Calcular', textAlign: TextAlign.left, style: TextStyle(
							fontFamily: "Netflix",
							fontWeight: FontWeight.w600,
							fontSize: 18,
							letterSpacing: 0.0,
							color: Colors.white,
						),
					),
				),
			),
		);
	}

	Widget _drawer(context){
		return Drawer(
			child: ListView(
				padding: EdgeInsets.zero,
				children: [
					const DrawerHeader(
						decoration: BoxDecoration(
							color: Color(0xff11ab6a),
						),
						child: Text('Drawer Header'),
					),
					ListTile(
						title: const Text('Repla vinos'),
						onTap: () {
							// Update the state of the app
							// ...
							// Then close the drawer
							Navigator.pop(context);
						},
					),
					ListTile(
						title: const Text('Salir'),
						onTap: () {
							Get.offAllNamed("login");
						},
					),
				],
			),
		);
	}
}