import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
	fontSize: size.height * 0.040,
	fontWeight: FontWeight.bold,
);

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
	fontSize: size.height * 0.030,
);

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

TextStyle kLoginOrSignUpTextStyle(
	Size size,
) =>
GoogleFonts.ubuntu(
	fontSize: size.height * 0.022,
	fontWeight: FontWeight.w500,
	color: const Color(0xff4bbf78),
);

TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.black);

InputDecoration authFormFieldStyle() => const InputDecoration(
	iconColor: Color(0xff4bbf78),
	prefixIconColor: Color(0xff4bbf78),
	suffixIconColor: Color(0xff4bbf78),
	floatingLabelStyle: TextStyle(color: Color(0xff4bbf78)),
	// prefixIcon: Icon(Icons.calendar_today, color: Color(0xff111b31)),
	focusedBorder: OutlineInputBorder(
		borderSide: BorderSide(color: Color(0xff4bbf78), width: 2.0),
		borderRadius: BorderRadius.all(Radius.circular(15)),
	),
	border: OutlineInputBorder(
		borderRadius: BorderRadius.all(Radius.circular(15)),
	),
);

InputDecoration formFieldStyle() => const InputDecoration(
	// prefixIcon: Icon(Icons.calendar_today, color: Color(0xff111b31)),
	iconColor: Color(0xff111b31),
	labelStyle: TextStyle(color: Color(0xff111b31)),
	filled: true,
	border: OutlineInputBorder(
		borderRadius: BorderRadius.all(Radius.circular(10.0)),
		borderSide: BorderSide.none,
	),
);

