import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.titre = "",
    required this.onpressed,
    this.couleur,
    this.taillText
  });

  final String titre;
  final void Function()? onpressed;
  final Color? couleur;
  final double? taillText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(couleur),
          shape:MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Colors.white ,width: 1.5)
          ))
          ),
          onPressed: onpressed,
          child: Text(
            titre,
            style: TextStyle(fontSize: taillText),
          )),
    );
  }
}
