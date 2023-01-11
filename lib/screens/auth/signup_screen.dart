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
		return Container(
			padding: EdgeInsets.symmetric(horizontal: size.width > 800 ? size.width * 0.09 : size.width * 0.001),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				mainAxisSize: MainAxisSize.max,
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Expanded(
						flex: 4,
						child: RotatedBox(
							quarterTurns: 0,
							child: Image.asset(
								'assets/132033-green-login.gif',
								height: size.height * 0.5,
								width: double.infinity,
								fit: BoxFit.contain,
							),
						),
					),
					SizedBox(width: size.width * 0.06),
					Expanded(
						flex: 5,
						child: _buildMainBody(size, theme),
					),
				],
			),
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
			mainAxisAlignment:size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
			children: [
		  		Center(
					child: Image.asset(
						'assets/logoid2.png',
						height: 140,
						width: 400,
					),
				),

		  		SizedBox(
		  			height: size.height * 0.03,
		  		),
				
		  		Padding(
		  			padding: const EdgeInsets.only(left: 20.0),
		  			child: Text(
		  				'sign_up'.tr,
		  				style: kLoginTitleStyle(size),
		  			),
		  		),
		  		const SizedBox(
		  			height: 10,
		  		),
		  		Padding(
		  			padding: const EdgeInsets.only(left: 20.0),
		  			child: Text(
		  				'create_account'.tr,
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
		  						decoration: authFormFieldStyle().copyWith(
		  							prefixIcon: const Icon(Icons.person, color: Color(0xff4bbf78)),
		  							labelText: 'name'.tr,
		  							hintText: 'name_hint'.tr,									
		  						),

		  						controller: authController.nameTextController,
		  						// The validator receives the text that the user has entered.
		  						validator: (value) => (value!.isEmpty) ? 'field_required'.tr : null
		  					),
		  					SizedBox(
		  						height: size.height * 0.02,
		  					),

		  					/// Gmail
		  					TextFormField(
		  						style: kTextFormFieldStyle(),
		  						controller: authController.emailTextController,
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
		  						controller: authController.passwordTextController,
								obscureText: true,
								autocorrect: false,
		  						decoration: authFormFieldStyle().copyWith(
		  							prefixIcon: const Icon(Icons.lock_open, color: Color(0xff4bbf78)),
		  							labelText: "password".tr,
		  							hintText: "password_hint".tr,
		  						),
		  						// The validator receives the text that the user has entered.
		  						validator: (value) => (value!.isMinString) ? null : 'digits'.tr
		  					),

		  					SizedBox(
		  						height: size.height * 0.01,
		  					),
		  					Text(
		  						'login_footer'.tr,
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
		  									text: 'account_exists'.tr,
		  									style: kHaveAnAccountStyle(size),
		  									children: [
		  										TextSpan(
		  											text: " ${"login".tr}",
		  											style: kLoginOrSignUpTextStyle(size)
												),
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
				},
				child: Text('sign_up'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
			),
		);
	}
}