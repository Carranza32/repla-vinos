// ignore_for_file: deprecated_member_use

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:repla_vinos/constants.dart';
import 'package:repla_vinos/controllers/calculation_controller.dart';
import 'package:select_dialog/select_dialog.dart';


import '../models/plaguidas_model.dart';
import '../models/user_model.dart';

class FormCalculationScreen extends StatelessWidget {
	final CalculationController calculationController = Get.put(CalculationController());
  	final _formKey = GlobalKey<FormState>();

  	FormCalculationScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final textTheme = Theme.of(context).textTheme;
		var size = MediaQuery.of(context).size;

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
								_header(context, textTheme, calculationController, size),							
								SizedBox(
								width: size.width > 800 ? size.width * 0.67 : size.width * 0.85,
								child: ListView(
								primary: false,
								shrinkWrap: true,
								children: [
									const SizedBox(height: 30),

									Text('application_date'.tr, style: textTheme.headline6),

									const SizedBox(height: 15),

									GestureDetector(
										child: TextFormField(
											controller: calculationController.fechaTextController,
											enabled: false,
											decoration: formFieldStyle().copyWith(
												labelText: 'date'.tr,											
											),
											validator: (value) => value!.isEmpty ? 'field_required'.tr : null,
										),
										onTap: () {
											showDatePicker(
												context: context,
												initialDate: calculationController.fechaTextController.text.isEmpty ? DateTime.now() : DateFormat('dd/MM/yyyy').parse(calculationController.fechaTextController.text),
												firstDate: DateTime(2000),
												lastDate: DateTime(2100),
												cancelText: 'cancel'.tr,
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

									Text('grape'.tr, style: textTheme.headline6),

									const SizedBox(height: 15),

									TextFormField(
										controller: calculationController.diametroTextController,
										decoration: formFieldStyle().copyWith(
											labelText: 'diameter'.tr,											
										),
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}'))],
										validator: (value) => value!.isEmpty ? 'field_required'.tr : null,
									),

									const SizedBox(height: 20),

									Text('plaguicida'.tr, style: textTheme.headline6),

									const SizedBox(height: 20),

									GestureDetector(
										child: TextFormField(
											controller: calculationController.plaguicidaTextController,
											enabled: false,
											decoration: formFieldStyle().copyWith(
												labelText: 'plaguicida'.tr,											
											),
											validator: (value) => value!.isEmpty ? 'field_required'.tr : null,
										),
										onTap: () {
											SelectDialog.showModal<Plaguicida>(
												context,
												label: 'plaguicida'.tr,
												searchHint: 'search_plaguicida'.tr,
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

									Text('dosis_field'.tr, style: textTheme.headline6),

									const SizedBox(height: 15),

									TextFormField(
										controller: calculationController.dosisTextController,
										decoration: formFieldStyle().copyWith(
											labelText: 'dosis'.tr,											
										),
										validator: (value) => value!.isEmpty ? 'field_required'.tr : null,
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}'))],
									),

									const SizedBox(height: 25),

									Padding(
										padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
										child: _formButton(context),
									),

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

	Widget _header(context, textTheme, CalculationController calculationController, size) {

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
					child: Text('form_title'.tr, style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)),
				),

				Center(
				  child: Container(
					alignment: Alignment.center,
					margin: const EdgeInsets.only(top: 75),
				  	width: size.width > 800 ? size.width * 0.70 : size.width * 0.95,
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
				  			Text('vini'.tr, style: textTheme.headline6),

				  			const SizedBox(height: 20),

				  			CustomSlidingSegmentedControl(
								controller: calculationController.vinoTextController,
				  				isStretch: true,
				  				initialValue: 'tinto',
				  				children: {
				  					'tinto': Text('tinto_grape'.tr, style: const TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16) ),
				  					'blanco': Text('white_grape'.tr, style: const TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16)),
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
				child: Center(
					child: Text('calc'.tr, textAlign: TextAlign.left, style: const TextStyle(
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
		Usuario user = Usuario();
		var data = GetStorage().read('user');
		
		try {		  	
			user = (data is Usuario) ? data : Usuario.fromJson(data);
		} catch (e) {
		 	user = Usuario();
		}

		return Drawer(
			child: ListView(
				padding: EdgeInsets.zero,
				children: [
					UserAccountsDrawerHeader(
						currentAccountPicture: const CircleAvatar(
                  	backgroundImage: AssetImage('assets/logoid.png'),
                	),
						decoration: const BoxDecoration(
							color: Color(0xff11ab6a),
						),
						accountEmail: Text(user.email ?? ''),
						accountName: Text(user.nombre ?? '', style: const TextStyle(fontSize: 24.0)),
					),
					ListTile(
						title: Text('profile'.tr),
						onTap: () {
							Get.toNamed("profile");
						},
					),
					ListTile(
						title: Text('app_title'.tr),
						onTap: () {
							Get.toNamed('intro');
						},
					),
					ListTile(
						title: Text('log_out'.tr),
						onTap: () {
							Get.offAllNamed("login");
						},
					),
				],
			),
		);
	}
}