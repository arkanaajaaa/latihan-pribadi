import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final bool allowDecimal; // opsional: true jika mau angka desimal

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labeltext,
    this.allowDecimal = false, // default tidak menerima desimal
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        allowDecimal
            ? FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')) // angka + titik
            : FilteringTextInputFormatter.digitsOnly, // hanya angka
      ],
      decoration: InputDecoration(
        labelText: labeltext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}