import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';

class FormCalculationScreen extends StatelessWidget {
  	const FormCalculationScreen({Key? key}) : super(key: key);
	@override
	Widget build(BuildContext context) {

		TextEditingController _date = TextEditingController();
		String plaguicida= "No value selected";
		final textTheme = Theme.of(context).textTheme;

		return SafeArea(
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: const Color(0xff11ab6a),
				),
				drawer: _drawer(context),
				body: SingleChildScrollView(
					child: Column(
					  	children: [
							_header(context, textTheme),							
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

									TextField(
										controller: _date,
										decoration: const InputDecoration(
											labelText: 'Fecha Aplicacion',
											labelStyle: TextStyle(color: Color(0xff111b31)),
											prefixIcon: Icon(Icons.calendar_today, color: Color(0xff111b31)),
											filled: true,
											border: OutlineInputBorder(
												borderRadius: BorderRadius.all(Radius.circular(10.0)),
												borderSide: BorderSide.none,
											),
										),
										onTap: () {
											showDatePicker(
												context: context,
												initialDate: DateTime.now(),
												firstDate: DateTime(2000),
												lastDate: DateTime(2100),
											).then((date) {
												_date.text = DateFormat('dd/MM/yyyy').format(date!);
											});
										},
									),

									const SizedBox(height: 20),

									Text('Diametro uva (mm)', style: textTheme.headline6),

									const SizedBox(height: 15),

									TextField(
										decoration: const InputDecoration(
											labelText: 'Diametro',
											labelStyle: TextStyle(color: Color(0xff111b31)),
											filled: true,
											border: OutlineInputBorder(
												borderRadius: BorderRadius.all(Radius.circular(10.0)),
												borderSide: BorderSide.none,
											),
										),
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										onTap: () {
											
										},
									),

									const SizedBox(height: 20),

									Text('Plaguicida', style: textTheme.headline6),

									DropdownButton(
										isExpanded: true,								
										items: List.generate(50, (index) => "Item $index").map((e) => DropdownMenuItem(
											value: e,
											child: Text(e),
										)).toList(),
										onChanged: (value) {
											plaguicida = value.toString();
										},
									),

									const SizedBox(height: 20),

									Text('Dosis (g activo/ha)', style: textTheme.headline6),

									const SizedBox(height: 15),

									TextField(
										decoration: const InputDecoration(
											labelText: 'Dosis',
											labelStyle: TextStyle(color: Color(0xff111b31)),
											filled: true,
											border: OutlineInputBorder(
												borderRadius: BorderRadius.all(Radius.circular(10.0)),
												borderSide: BorderSide.none,
											),
										),
										keyboardType: const TextInputType.numberWithOptions(decimal: true),
										onTap: () {
											
										},
									),

									const SizedBox(height: 15),

									_formButton(context),

									const SizedBox(height: 25),
								],
							),
					    	),
					  	],
					),
				)
			),
		);
	}

	Widget _header(context, textTheme){

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
				  				isStretch: true,
				  				initialValue: 1,
				  				children: const {
				  					1: Text('Tinto', style: TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16) ),
				  					2: Text('Blanco', style: TextStyle(color: Color(0xff111b31), fontWeight: FontWeight.bold, fontSize: 16)),
				  				},
				  				duration: const Duration(milliseconds: 300),
				  				curve: Curves.easeInToLinear,
				  				onValueChanged: (v) {
				  					
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
		return Container(
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
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Calcular',
                  textAlign: TextAlign.left,
                  style: TextStyle(
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
						title: const Text('Item 1'),
						onTap: () {
							// Update the state of the app
							// ...
							// Then close the drawer
							Navigator.pop(context);
						},
					),
					ListTile(
						title: const Text('Item 2'),
						onTap: () {
							// Update the state of the app
							// ...
							// Then close the drawer
							Navigator.pop(context);
						},
					),
				],
			),
		);
	}
}