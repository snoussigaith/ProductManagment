


import 'package:flutter/material.dart';
import 'package:gestionproduit2/entite/article.dart';


class EditProduct extends StatefulWidget {
  //final Article article;
  EditProduct({super.key});
  
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
 // Article art=
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit"),
      ),
        body: Text("lasf"),
    );
  }
}