import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repla_vinos/controllers/auth_controller.dart';
import 'package:lottie/lottie.dart';
import '../../constants.dart';
import 'package:repla_vinos/utils/validations.dart';

class RecuperateScreen extends StatelessWidget {
	final AuthController authController = Get.put(AuthController());
  	final _formKey = GlobalKey<FormState>();

  	RecuperateScreen({super.key});

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
							return _buildSmallScreen(size);
						}
					},
				),
			),
		);
	}

	/// For large screens
	Widget _buildLargeScreen(Size size, context) {		
		return Container(
			height: size.height,
			width: size.width,
			decoration: const BoxDecoration(
				image: DecorationImage(
					image: AssetImage('assets/Diseño_sin_título.png'),
					fit: BoxFit.cover,
					alignment: Alignment.topCenter,
					opacity: 0.2
				),
			),
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: size.width > 800 ? size.width * 0.09 : size.width * 0.001),
				child: Row(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					mainAxisSize: MainAxisSize.max,
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Expanded(
							flex: 4,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Image.asset(
										'assets/logoid2.png',
										height: 140,
										width: 400,
									),

									RotatedBox(
										quarterTurns: 0,
										child: Image.asset(
											'assets/animation_500_lft97u10.gif',
											height: size.height * 0.5,
											width: double.infinity,
											fit: BoxFit.contain,
										),
									),

									Image.asset(
										'assets/Logos_frase01bg.png',
										height: 140,
										width: 400,
									),
								],
							),
						),
						SizedBox(width: size.width * 0.06),
						Expanded(
							flex: 5,
							child: _buildMainWebBody(size),
						),
					],
				),
			),
		);
	}

	/// For Small screens
	Widget _buildSmallScreen(Size size) {
			return SingleChildScrollView(
			  child: Center(
			  	child: _buildMainBody(size),
			  ),
			);
		}

	/// Main Body
	Widget _buildMainBody(Size size) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
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
						'recuperate'.tr,
						style: kLoginTitleStyle(size),
					),
				),
				const SizedBox(
					height: 10,
				),
				SizedBox(
					height: size.height * 0.03,
				),
				Padding(
					padding: const EdgeInsets.only(left: 20.0, right: 20),
					child: Form(
						key: _formKey,
						autovalidateMode: AutovalidateMode.onUserInteraction,
						child: Column(
							children: [
								TextFormField(
									keyboardType: TextInputType.emailAddress,
									style: kTextFormFieldStyle(),
									decoration: authFormFieldStyle().copyWith(
										prefixIcon: const Icon(Icons.person, color: Color(0xff4bbf78),),
										labelText: 'email'.tr,
										hintText: 'email_hint'.tr,
									),
									controller: authController.emailTextController,
									validator: (value) => (value!.isMyEmail) ? null : 'email_wrong'.tr,
								),
								SizedBox(
									height: size.height * 0.02,
								),

								/// Login Button
								loginButton(),
								SizedBox(
									height: size.height * 0.03,
								),

								/// Navigate To Login Screen
								GestureDetector(
									onTap: () {
										Get.toNamed('login');

										authController.emailTextController.clear();
										authController.passwordTextController.clear();
										
										_formKey.currentState?.reset();
									},
									child: RichText(
										text: TextSpan(
											text: 'account_already_exists'.tr,
											style: kHaveAnAccountStyle(size),
											children: [
												TextSpan(
													text: " ${"return".tr}",
													style: kLoginOrSignUpTextStyle(
														size,
													),
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

	/// Main Body for web
	Widget _buildMainWebBody(Size size) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
			children: [
				Center(
					child: Text(
						'BIENVENIDOS A REPLAVINOS',
						style: TextStyle(
							fontSize: size.height * 0.050,
							fontWeight: FontWeight.bold,
							color: Colors.black,

						),
					),
				),

				Center(
					child: Text(
						'Periodos de Resguardo de Plaguicidas en Uva Vinífera',
						style: TextStyle(
							fontSize: size.height * 0.020,
							color: Colors.black,
						),
					),
				),

				SizedBox(
					height: size.height * 0.03,
				),
				
				const SizedBox(
					height: 10,
				),
				SizedBox(
					height: size.height * 0.03,
				),
				Container(
					padding: const EdgeInsets.all(20),
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(10),
						color: const Color.fromARGB(172, 70, 97, 36),
					),
					child: Form(
						key: _formKey,
						autovalidateMode: AutovalidateMode.onUserInteraction,
						child: Column(
							children: [
								Padding(
									padding: const EdgeInsets.only(bottom: 5.0),
									child: Text(
										'recuperate'.tr,
										style: kLoginTitleStyle(size),
									),
								),

								TextFormField(
									keyboardType: TextInputType.emailAddress,
									style: kTextFormFieldStyle(),
									decoration: authFormFieldStyle().copyWith(
										prefixIcon: const Icon(Icons.person, color: Color(0xff4bbf78),),
										labelText: 'email'.tr,
										hintText: 'email_hint'.tr,
										fillColor: Colors.white,
										filled: true,
									),
									controller: authController.emailTextController,
									validator: (value) => (value!.isMyEmail) ? null : 'email_wrong'.tr,
								),
								SizedBox(
									height: size.height * 0.02,
								),

								SizedBox(
									height: size.height * 0.03,
								),

								SizedBox(
									height: size.height * 0.02,
								),
								Text(
									'login_footer'.tr,
									style: kLoginTermsAndPrivacyStyle(size),
									textAlign: TextAlign.center,
								),
								SizedBox(
									height: size.height * 0.02,
								),

								/// Login Button
								loginButton(isWhite: true),
								SizedBox(
									height: size.height * 0.03,
								),

								loginButtonPage(isWhite: true),							
							],
						),
					),
				),
			],
		);
	}

	// Login Button
	Widget loginButton({bool isWhite = false}) {
		return SizedBox(
			width: double.infinity,
			height: 55,
			child: ElevatedButton(
				style: ElevatedButton.styleFrom(
					backgroundColor: (isWhite) ? Colors.white : const Color(0xffa3fb82),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(15),
					),
				),
				onPressed: () {
					if (_formKey.currentState!.validate()) {
						authController.resetPassword();
					}
				},
				child: Text('recuperate_password'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
			),
		);
	}

	// Go to Login Page
	Widget loginButtonPage({bool isWhite = false}) {
		return SizedBox(
			width: double.infinity,
			height: 55,
			child: ElevatedButton(
				style: ElevatedButton.styleFrom(
					backgroundColor: (isWhite) ? Colors.white : const Color(0xffa3fb82),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(15),
					),
				),
				onPressed: () {
					Get.toNamed('login');

					authController.emailTextController.clear();
					authController.passwordTextController.clear();
					
					_formKey.currentState?.reset();
				},
				child: Text('return'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff111b31))),
			),
		);
	}
}