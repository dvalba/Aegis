import 'package:aegis/presentation/provider/auth/auth_provider.dart';
import 'package:aegis/presentation/provider/auth/login_form_provider.dart';
import 'package:aegis/presentation/widgets/shared/buttom/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/shared/forms/custom_icon_text_form_field.dart';
import '../../widgets/shared/logos/derma_text_logo.dart';
import '../../widgets/shared/buttom/navigation_text_button.dart'; // Importando el widget de botón de navegación

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              DermaTextLogo(),
              _LoginForm(),
              // Forgot Password Link - Usando el widget NavigationTextButton
              NavigationTextButton(
                text: '¿Olvidaste tu contraseña?',
                routeName:
                    'SignUp', // Ruta a la que irá para recuperar la contraseña
                textColor: colors.secondary,
                fontSize: 14.0,
                decoration: TextDecoration.underline,
              ),
              // Register Link - Usando el widget NavigationTextButton
              NavigationTextButton(
                text: '¿No tienes una cuenta? Regístrate ahora',
                routeName: 'SignUp', // Ruta al formulario de registro
                textColor: colors.secondary,
                fontSize: 14.0,
                decoration: TextDecoration.underline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  
  const _LoginForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final loginProvider = ref.watch(loginFormProvider);
    ref.listen(authProvider, (previous,next){

      if(next.errorMessage.isNotEmpty){
        showSnackbar(context,next.errorMessage);
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          // Email Field - Usando el widget CustomTextField
          CustomIconTextFormField.email(
            onChanged: ref.read(loginFormProvider.notifier).updateEmail,
            errorText: loginProvider.formPosted ? loginProvider.email.errorText : null,
          ),
          const SizedBox(height: 10),
          // Password Field - Usando el widget CustomTextField
          CustomIconTextFormField.password(
            onChanged: ref.read(loginFormProvider.notifier).updatePassword,

            errorText: loginProvider.formPosted ? loginProvider.password.errorText:null,
          ),

          const SizedBox(height: 20),
          // Login Button - Usando el widget NavigationButton
          SubmitButton(
            label: 'Iniciar sesión',
            onPressed: ref.read(loginFormProvider.notifier).submitForm,
            backgroundColor: colors.primary,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
  
  void showSnackbar(BuildContext context, String errorMessage) {

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),));
  }
}
