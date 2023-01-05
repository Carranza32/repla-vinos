import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:repla_vinos/controllers/auth_controller.dart';
import '../../constants.dart';
import 'package:repla_vinos/utils/validations.dart';

class SignUpScreen extends StatelessWidget {
	final AuthController authController = Get.put(AuthController());
	final _formKey = GlobalKey<FormState>();

	SignUpScreen({super.key});

	@override
	Widget build(BuildContext context) {
		var size = MediaQuery.of(context).size;
		var theme = Theme.of(context);

		return GestureDetector(
			onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
			child: Scaffold(
				backgroundColor: Colors.white,
				resizeToAvoidBottomInset: false,
				body: LayoutBuilder(
					builder: (context, constraints) {
					if (constraints.maxWidth > 600) {
						return _buildLargeScreen(size, theme);
					} else {
						return _buildSmallScreen(size, theme);
					}
					},
				)
			),
		);
	}

	/// For large screens
	Widget _buildLargeScreen(Size size, ThemeData theme) {
		return Row(
			children: [
				Expanded(
					flex: 4,
					child: RotatedBox(
						quarterTurns: 3,
						child: Lottie.asset(
							'assets/coin.json',
							height: size.height * 0.3,
							width: double.infinity,
							fit: BoxFit.fill,
						),
					),
				),
				SizedBox(width: size.width * 0.06),
				Expanded(
					flex: 5,
					child: _buildMainBody(size, theme),
				),
			],
		);
	}

	/// For Small screens
	Widget _buildSmallScreen(Size size, ThemeData theme) {
		return Center(
			child: _buildMainBody(size, theme),
		);
	}

	/// Main Body
	Widget _buildMainBody(Size size, ThemeData theme) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment:
				size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
			children: [
				size.width > 600
					? Container()
					: Lottie.asset(
						'assets/wave.json',
						height: size.height * 0.2,
						width: size.width,
						fit: BoxFit.fill,
					),
				SizedBox(
					height: size.height * 0.03,
				),
				Padding(
					padding: const EdgeInsets.only(left: 20.0),
					child: Text(
						'Sign Up',
						style: kLoginTitleStyle(size),
					),
				),
				const SizedBox(
					height: 10,
				),
				Padding(
					padding: const EdgeInsets.only(left: 20.0),
					child: Text(
						'Create Account',
						style: kLoginSubtitleStyle(size),
					),
				),
				SizedBox(
					height: size.height * 0.03,
				),
				Padding(
					padding: const EdgeInsets.only(left: 20.0, right: 20),
					child: Form(
						key: _formKey,
						child: Column(
						children: [
							/// username
							TextFormField(
								style: kTextFormFieldStyle(),
								decoration: const InputDecoration(
									prefixIcon: Icon(Icons.person),
									hintText: 'Nombre',
									labelText: 'Nombre',
									focusedBorder: OutlineInputBorder(
										borderSide: BorderSide(color: Color(0xff4bbf78), width: 2.0),
										borderRadius: BorderRadius.all(Radius.circular(15)),
									),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.all(Radius.circular(15)),
									),
								),

								controller: authController.nameTextController,
								// The validator receives the text that the user has entered.
								validator: (value) => (value!.isMinString) ? null : 'Debe ser un número de 8 dígitos.'
							),
							SizedBox(
								height: size.height * 0.02,
							),

							/// Gmail
							TextFormField(
								style: kTextFormFieldStyle(),
								controller: authController.emailTextController,
								decoration: const InputDecoration(
									prefixIcon: Icon(Icons.email_rounded),
									hintText: 'Ingrese su email',
									labelText: 'Email',
									focusedBorder: OutlineInputBorder(
										borderSide: BorderSide(color: Color(0xff4bbf78), width: 2.0),
										borderRadius: BorderRadius.all(Radius.circular(15)),
									),
									border: OutlineInputBorder(
										borderRadius: BorderRadius.all(Radius.circular(15)),
									),
								),
								// The validator receives the text that the user has entered.
								validator: (value) => (value!.isMyEmail) ? null : 'Email no valido',
							),
							SizedBox(
								height: size.height * 0.02,
							),

							/// password
							TextFormField(
								style: kTextFormFieldStyle(),
								controller: authController.passwordTextController,
								decoration: const InputDecoration(
									prefixIcon: Icon(Icons.lock_open),
									hintText: "Ingrese su clave",
									labelText: "Clave",
									border: OutlineInputBorder(
										borderRadius: BorderRadius.all(Radius.circular(15)),
									),
								),
								// The validator receives the text that the user has entered.
								validator: (value) => (value!.isMinString) ? null : 'Debe ser un número de 8 dígitos.'
							),

							SizedBox(
								height: size.height * 0.01,
							),
							Text(
								'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
								style: kLoginTermsAndPrivacyStyle(size),
								textAlign: TextAlign.center,
							),
							SizedBox(
								height: size.height * 0.02,
							),

							/// SignUp Button
							signUpButton(theme),
							SizedBox(
								height: size.height * 0.03,
							),

								/// Navigate To Login Screen
								GestureDetector(
									onTap: () {
										Get.toNamed("login");

										authController.emailTextController.clear();
										authController.nameTextController.clear();
										authController.passwordTextController.clear();

										_formKey.currentState?.reset();
									},
									child: RichText(
										text: TextSpan(
											text: '¿Ya tienes una cuenta?',
											style: kHaveAnAccountStyle(size),
											children: [
												TextSpan(
													text: " Login",
													style: kLoginOrSignUpTextStyle(size)),
											],
										),
									),
								),
							],
						),
					),
				),
			],
		);
	}

	// SignUp Button
	Widget signUpButton(ThemeData theme) {
		return SizedBox(
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
					// Validate returns true if the form is valid, or false otherwise.
					if (_formKey.currentState!.validate()) {
						authController.register();
					}
					Get.offAllNamed("form_calculation");
				},
				child: const Text('Registrarse', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
			),
		);
	}
}