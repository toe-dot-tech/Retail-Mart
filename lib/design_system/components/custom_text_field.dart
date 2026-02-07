
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retail_mart/design_system/tokens/colors.dart';
// NOTE: Ensure usernameErrorProvider is in a separate file or the main widget file
// if you want this CustomTextField to remain in its own file.

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged? onChanged;
  final Color borderColor;
  final Color labelColor;
  final Color backgroundColor;

  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLength;

  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final int? maxLines;

  // 🔑 This is the external state that comes from Riverpod
  final String? externalError;

  const CustomTextField({
    super.key,
    required this.label,
    required this.inputType,
    this.controller,
    required this.borderColor,
    required this.labelColor,
    required this.backgroundColor,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.maxLines,
    this.onChanged,
    this.externalError,
    this.initialValue,
    this.maxLength, // Must be passed by the widget calling CustomTextField
  });

  @override
  Widget build(BuildContext context) {
    // 1. Define the combined validator function
    String? combinedValidator(String? value) {
      // A. Check for external error first (Highest priority: e.g., Username Taken)
      if (externalError != null) {
        return externalError;
      }

      // B. Check for internal sync error (Format, length, empty checks)
      if (validator != null) {
        return validator!(value);
      }

      // C. No errors
      return null;
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        // controller: controller,
        initialValue: initialValue,
        onChanged: onChanged,

        // 🔑 CRITICAL FIX: Use the combinedValidator here 🔑
        validator: combinedValidator,

        inputFormatters: inputFormatters,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,

        maxLength: maxLength,

        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: labelColor),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.textFieldBackground,
          counterText: '', // This hides the counter

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor, width: 1.4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor, width: 0.6),
          ),
          // IMPORTANT: To show a red border on error, ensure you have defined
          // errorBorder and focusedErrorBorder in your InputDecoration.
          // (They are missing here, but were in the previous complete example).
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 10.0,
          ),
        ),
      ),
    );
  }
}
