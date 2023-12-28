import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.typeClavier,
      this.label = "",
      this.hint = "",
      this.filterInput,
      this.validation,
      this.onsaved
      });

  final TextInputType? typeClavier;
  final String label;
  final String hint;
  final List<TextInputFormatter>? filterInput;
  final String? Function(String?)? validation;
  final void Function(String?)? onsaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.green, fontSize: 18),
      keyboardType: typeClavier,
      inputFormatters: filterInput,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 15),
        fillColor: Colors.yellowAccent.withOpacity(0.5),
        filled: true,
        label: Text(label),
        labelStyle: TextStyle(fontSize: 20),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.blueAccent, fontSize: 20),
        prefixIcon: Icon(Icons.description),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red)),
      ),
      validator: validation,
      onSaved: onsaved,
    );
  }
}
