import 'package:aegis/presentation/widgets/shared/logos/derma_text_logo.dart';
import 'package:aegis/presentation/widgets/shared/buttom/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de la app
              const DermaTextLogo(),
              const SizedBox(height: 50),

              // Botón de "Iniciar sesión"
              NavigationButton(
                label: 'Iniciar sesión',
                routeName: 'Loader',
                backgroundColor: colors.primary,
                textColor: Colors.white,
              ),
              const SizedBox(height: 20),

              // Texto para "Registrarse ahora"
              TextButton(
                onPressed: () {
                  context.pushNamed('SignUp'); // Ruta a SignUpPage
                },
                child: Text(
                  '¡Regístrate ahora!',
                  style: TextStyle(
                    color: colors.secondary,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Botones de navegación adicionales
              NavigationButton(
                label: 'Ir a Home Page',
                routeName: 'Home',
                backgroundColor: colors.primary,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
