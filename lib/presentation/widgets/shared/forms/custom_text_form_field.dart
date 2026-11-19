import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final int maxLines;
  final OutlineInputBorder border;

  CustomTextFormField({
    super.key,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    OutlineInputBorder? border,
  }) : border = border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null
          ? initialValue
          : null, // Usa initialValue si no hay controller
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines > 0 ? maxLines : 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        isDense: true,
        hintText: hintText,
        errorText: errorText,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red[900]!),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red[900]!),
        ),
      ),
    );
  }

  // Métodos estáticos para tipos de campos con valores iniciales
  static CustomTextFormField patientId({
    String labelText = "Patient Id",
    String hintText = "Enter Patient Id",
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 1,
    OutlineInputBorder? border,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      border: border,
    );
  }

  static CustomTextFormField name({
    String labelText = "Name",
    String hintText = "Enter Name",
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 1,
    OutlineInputBorder? border,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      border: border,
    );
  }

  static CustomTextFormField lastName({
    String labelText = "Last Name",
    String hintText = "Enter Last Name",
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 1,
    OutlineInputBorder? border,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      border: border,
    );
  }

  static CustomTextFormField age({
    String labelText = "Age",
    String hintText = "Enter Age",
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 1,
    OutlineInputBorder? border,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      border: border,
    );
  }

  static CustomTextFormField personalHealthRecord({
    String labelText = "Personal Health Record",
    String hintText = "Enter Personal Health Record",
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    bool enabled = true,
    int maxLines = 5,
    OutlineInputBorder? border,
  }) {
    return CustomTextFormField(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      border: border,
    );
  }
}
