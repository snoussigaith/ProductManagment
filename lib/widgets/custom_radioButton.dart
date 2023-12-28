import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {super.key,
       this.titre="",
       required this.value,
       required this.groupvalue,
       required this.onchanged
      });

  final String  value;
  final String titre;
  final String groupvalue;
  final void Function(String?)? onchanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupvalue, onChanged: onchanged),
        Text(
          titre,
          style: TextStyle(fontSize: 18, color: Colors.blue),
        )
      ],
    );
  }
}
