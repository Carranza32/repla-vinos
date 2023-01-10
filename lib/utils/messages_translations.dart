import 'package:get/get.dart';

class LanguageTranslations extends Translations {
	@override
  	Map<String, Map<String, String>> get keys => {
		'en_US': {
			'title': 'English',
			'login': 'Login',
			'signup': 'Sign Up',
			'email': 'Email',
			'password': 'Password',
			'name': 'Name',
			'confirm_password': 'Confirm Password',
			'forgot_password': 'Forgot Password?',
			'dont_have_account': 'Don\'t have an account?',
			'already_have_account': 'Already have an account?',
			'create_account': 'Create Account',
			'login_with_google': 'Login with Google',
			'login_with_facebook': 'Login with Facebook',
			'login_with_apple': 'Login with Apple',
			'login_with_email': 'Login with Email',
			'signup_with_google': 'Sign Up with Google',
			'signup_with_facebook': 'Sign Up with Facebook',
			'signup_with_apple': 'Sign Up with Apple',
			'signup_with_email': 'Sign Up with Email',
			'email_address': 'Email Address',
			'password_reset': 'Password Reset',
			'send_password_reset_link': 'Send Password Reset Link',
			'reset_password': 'Reset Password',
			'new_password': 'New Password',
			'confirm_new_password': 'Confirm New Password',
			'save': 'Save',
			'cancel': 'Cancel',
			'logout': 'Logout',
			'home': 'Home',
			'profile': 'Profile',
			'settings': 'Settings',
			'language': 'Language',
			'english': 'English',
			'spanish': 'Spanish',
		},
		'es': {
			'app_title': 'Repla vinos',

			'login': 'Iniciar',
			'sign_up': 'Registrarme',
			'recuperate': 'Recuperación',

			'name': 'Nombre',
			'name_hint': 'Ingrese su nombre',
			'email': 'Email',
			'email_hint': 'Ingrese su email',
			'password': 'Clave',
			'password_confirm': 'Repetir clave',
			'password_hint': 'Ingrese su clave',

			'login_footer': 'Crear una cuenta significa que está de acuerdo con nuestros Términos de servicio y nuestra Política de privacidad',
			'account_exists': '¿No tienes una cuenta?',
			'account_already_exists': '¿Ya tienes una cuenta?',
			'register': 'Registrarme',
			'login_button': 'Iniciar',
			'create_account': 'Crear cuenta',
			'recuperate_password': 'Recuperar clave',
			'forgot_password': '¿Olvidó su contraseña?',
			'return': 'Regresar',
			'profile': 'Perfil',
			'update_profile': 'Actualizar datos',
			'send_email': 'Enviar datos por email',

			'form_title': 'Registro de aplicación',
			'vini': 'Vinificación',
			'tinto_grape': 'Tinto',
			'white_grape': 'Blanco',
			'application_date': 'Fecha Aplicacion',
			'date': 'Fecha',
			'grape': 'Diametro uva (mm)',
			'diameter': 'Diametro',
			'plaguicida': 'Plaguicida',
			'search_plaguicida': 'Buscar plaguicida',
			'dosis_field': 'Dosis (g activo/ha)',
			'dosis': 'Dosis',
			'calc': 'Calcular',
			'log_out': 'Cerrar sesión',

			//Validaciones
			'email_wrong': 'Email no válido',
			'field_required': 'Este campo es requerido',
			'wrong_try_again': "Algo salió mal. Inténtalo de nuevo",
			'loading': "Cargando...",
			'cancel': "Cancelar",
			'digits' : 'Debe ser un número de 8 dígitos.',
			'wrong_email'  : 'No corresponde con una dirección de e-mail válida.',
		}
  	};
}