import 'package:flutter/material.dart';

class CustomIconTextFormField extends StatelessWidget {
  final String labelText; // Texto que aparecerá como etiqueta
  final IconData prefixIcon; // Ícono que aparecerá al inicio del campo
  final TextInputType keyboardType; // Tipo de teclado
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText; // Mensaje de error
  final bool enabled;
  final void Function(String)? onChanged;
  final bool obscureText; // Para ocultar el texto (para contraseñas)
  final String? Function(String?)? validator; // Función de validación, opcional
  final border = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54),
  );

  // Constructor general con parámetros opcionales
  const CustomIconTextFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.keyboardType,
    this.controller,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        isDense: true,
        hintText: hintText,
        errorText: errorText,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade900),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade900),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  // Factory para Email
  factory CustomIconTextFormField.email({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    bool enabled = true,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return CustomIconTextFormField(
      key: key,
      labelText: 'Email',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Factory para Password
  factory CustomIconTextFormField.password({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    String? labelText,
    bool enabled = true,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return CustomIconTextFormField(
      key: key,
      labelText: labelText?? 'Password',
      prefixIcon: Icons.lock,
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Factory para Username
  factory CustomIconTextFormField.username({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    bool enabled = true,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return CustomIconTextFormField(
      key: key,
      labelText: 'Username',
      prefixIcon: Icons.person,
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
    );
  }

  // Factory para Phone Number
  factory CustomIconTextFormField.phone({
    Key? key,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    bool enabled = true,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return CustomIconTextFormField(
      key: key,
      labelText: 'Phone Number',
      prefixIcon: Icons.phone,
      keyboardType: TextInputType.phone,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      enabled: enabled,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
