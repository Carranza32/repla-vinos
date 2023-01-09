import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/constants.dart';
import 'package:repla_vinos/utils/validations.dart';
import 'package:repla_vinos/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
	final ProfileController profileController = Get.put(ProfileController());
  	final _formKey = GlobalKey<FormState>();

	ProfileScreen({super.key});

	@override
	Widget build(BuildContext context) {
		var size = MediaQuery.of(context).size;

		return SafeArea(
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: const Color(0xff11ab6a),
				),
				body: SingleChildScrollView(
					child: Stack(
						children: [
							Container(
								width: MediaQuery.of(context).size.width,
								height: 200,
								decoration: const BoxDecoration(
									color: Color(0xff11ab6a),
									borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
								),
							),

							Container(
								alignment: Alignment.center,
								child: Text('profile'.tr, style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
							),

							Form(
								key: _formKey,
								child: Center(
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
												TextFormField(
													style: kTextFormFieldStyle(),
													decoration: authFormFieldStyle().copyWith(
														prefixIcon: const Icon(Icons.person, color: Color(0xff4bbf78)),
														labelText: 'name'.tr,
														hintText: 'name_hint'.tr,									
													),

													controller: profileController.nameTextController,
													// The validator receives the text that the user has entered.
													validator: (value) => (value!.isEmpty) ? 'field_required'.tr : null
												),
												SizedBox(
													height: size.height * 0.02,
												),

												/// Gmail
												TextFormField(
													style: kTextFormFieldStyle(),
													controller: profileController.emailTextController,
													decoration: authFormFieldStyle().copyWith(
														prefixIcon: const Icon(Icons.email_rounded, color: Color(0xff4bbf78)),
														hintText: 'Ingrese su email',
														labelText: 'Email',
													),
													// The validator receives the text that the user has entered.
													validator: (value) => (value!.isMyEmail) ? null : 'email_wrong'.tr,
												),
												SizedBox(
													height: size.height * 0.02,
												),

												/// password
												TextFormField(
													style: kTextFormFieldStyle(),
													controller: profileController.passwordTextController,
													decoration: authFormFieldStyle().copyWith(
														prefixIcon: const Icon(Icons.lock_open, color: Color(0xff4bbf78)),
														labelText: "password".tr,
														hintText: "password_hint".tr,
													),
													// The validator receives the text that the user has entered.
													validator: (value) => (value!.isMinString) ? null : 'digits'.tr
												),
												SizedBox(
													height: size.height * 0.02,
												),

												TextFormField(
													style: kTextFormFieldStyle(),
													controller: profileController.passwordRepeatTextController,
													decoration: authFormFieldStyle().copyWith(
														prefixIcon: const Icon(Icons.lock_open, color: Color(0xff4bbf78)),
														labelText: "password".tr,
														hintText: "password_confirm".tr,
													),
													// The validator receives the text that the user has entered.
													validator: (value) => (value!.isMinString) ? null : 'digits'.tr
												),
												SizedBox(
													height: size.height * 0.02,
												),

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
															if (_formKey.currentState!.validate()) {
																//profileController.login();
															}
														},
														child: Text('update_profile'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
													),
												),
											],
										),
									),
								),
							),
						
							
						],
					),
				),
			),
		);
	}
}