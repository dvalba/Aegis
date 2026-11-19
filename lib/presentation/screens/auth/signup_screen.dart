import 'package:aegis/presentation/widgets/shared/buttom/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/auth/signup_provider.dart';
import '../../widgets/shared/forms/custom_icon_text_form_field.dart';
import '../../widgets/shared/logos/derma_text_logo.dart';
import '../../widgets/shared/buttom/navigation_text_button.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final signupProvider = ref.watch(signupFormProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                const DermaTextLogo(),
                const SizedBox(height: 30),

                // Nombre de Usuario
                CustomIconTextFormField(
                  labelText: 'Nombre',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.name.errorText
                      : null,
                  onChanged: (value) =>
                      ref.read(signupFormProvider.notifier).updateName(value),
                ),
                const SizedBox(height: 20),

                CustomIconTextFormField(
                  labelText: 'Apellidos',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.lastName.errorText
                      : null,
                  onChanged: (value) => ref
                      .read(signupFormProvider.notifier)
                      .updateLastName(value),
                ),

                const SizedBox(height: 20),

                // Correo Electrónico
                CustomIconTextFormField(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  errorText: signupProvider.formPosted
                      ? signupProvider.email.errorText
                      : null,
                  onChanged: (value) =>
                      ref.read(signupFormProvider.notifier).updateEmail(value),
                ),
                const SizedBox(height: 20),

                // Contraseña

                CustomIconTextFormField.password(
                  labelText: 'Contraseña',
                  controller: _passwordController,
                  onChanged:
                      ref.read(signupFormProvider.notifier).updatePassword,
                  errorText: signupProvider.formPosted
                      ? signupProvider.password.errorText
                      : null,
                ),
                const SizedBox(height: 20),

                CustomIconTextFormField.password(
                  labelText: 'Confirmación',
                  controller: _confirmPasswordController,
                  onChanged: ref
                      .read(signupFormProvider.notifier)
                      .updateConfirmPassword,
                  errorText: signupProvider.formPosted
                      ? signupProvider.confirmPassword.errorText
                      : null,
                ),
                const SizedBox(height: 20),

                // Provincia
                CustomIconTextFormField(
                  labelText: 'Provincia',
                  prefixIcon: Icons.location_on,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.province.errorText
                      : null,
                  onChanged: (value) => ref
                      .read(signupFormProvider.notifier)
                      .updateProvince(value),
                ),
                const SizedBox(height: 20),

                // Municipio
                CustomIconTextFormField(
                  labelText: 'Municipio',
                  prefixIcon: Icons.location_city,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.municipality.errorText
                      : null,
                  onChanged: (value) => ref
                      .read(signupFormProvider.notifier)
                      .updateMunicipality(value),
                ),
                const SizedBox(height: 20),

                // Lugar de Trabajo
                CustomIconTextFormField(
                  labelText: 'Lugar de Trabajo',
                  prefixIcon: Icons.work,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.workPlace.errorText
                      : null,
                  onChanged: (value) => ref
                      .read(signupFormProvider.notifier)
                      .updateWorkPlace(value),
                ),
                const SizedBox(height: 20),

               CustomIconTextFormField(
                  labelText: 'Registro Profesional', 
                  prefixIcon: Icons.work,
                  keyboardType: TextInputType.text,
                  errorText: signupProvider.formPosted
                      ? signupProvider.regProfesional.errorText
                      : null,
                  onChanged: (value) => ref
                      .read(signupFormProvider.notifier)
                      .updateRegProfesional(value),
                ),
                const SizedBox(height: 20),



                SubmitButton(
                  label: 'Registrarse',
                  onPressed: () async {
                   final result = await ref.read(signupFormProvider.notifier).submitForm();
                    if (!result.isValid) {
                if (context.mounted) {
                  showSnackbar(context, result.errorMessage!);
                }
              }
                  },
                  backgroundColor: colors.primary,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 10),

                const NavigationTextButton(
                  text: '¿Ya tienes una cuenta? Inicia sesión aquí',
                  routeName: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Muestra un SnackBar con el mensaje de error.
  void showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
