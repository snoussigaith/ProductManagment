import 'package:flutter/material.dart';
import 'package:gestionproduit2/pages/accueil.dart';
import 'package:gestionproduit2/pages/add_Produit.dart';
import 'package:gestionproduit2/pages/all_Produit2.dart';

class MonMenu extends StatelessWidget {
  const MonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(currentAccountPicture: Icon(Icons.person, size:50 , color: Colors.white,),accountName: Text("user name"), accountEmail: Text("exemple@gmail.com")),
          createMenuItem(context,const Accueil(),"Accueil","consulter le dashboard ", Icons.dashboard),
         const Divider(height: 1,indent: 40,endIndent: 40, color: Colors.blue,),
          createMenuItem(context,const AddProduct()," Ajouter produit"," creer un nouveau produit",Icons.production_quantity_limits),
          const Divider(height: 1,indent: 40,endIndent: 40, color: Colors.blue,),
          createMenuItem(context,const AllProduit2(),"List des produit", "afficher l'ensemble des produits enregistree", Icons.list)

        ],
      ),
    );
  }

  ListTile createMenuItem(BuildContext context,dynamic page,String titleMenu,String description,IconData uneIcone) => 
  ListTile(
    title: Text("${titleMenu}"),
    subtitle: Text("${description}"),
    leading:Icon(uneIcone),
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>page));
    },
    );
}