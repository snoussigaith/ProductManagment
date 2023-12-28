
import 'package:flutter/material.dart';
import 'package:gestionproduit2/pages/add_Produit.dart';
import 'package:gestionproduit2/pages/all_Produit.dart';
import 'package:gestionproduit2/pages/all_Produit2.dart';

void main(){
  runApp(
   ProductCrud()
  );
}
class ProductCrud extends StatelessWidget {
  const ProductCrud({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:AllProduit2(),
      routes:{
        "addproduit":(context)=>AddProduct(),
       
      }
    );
  }
}

