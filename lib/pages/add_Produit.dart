

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestionproduit2/db/database_helper.dart';

import '../entite/article.dart';
import '../sqldb.dart';
import '../widgets/custom_Button.dart';
import '../widgets/custom_Textwidget.dart';
import '../widgets/custom_checkBox.dart';
import '../widgets/custom_radioButton.dart';
import 'all_Produit.dart';
import 'all_Produit2.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formkey = GlobalKey<FormState>();

  Sqldb sqldb=Sqldb();

  

   bool checkValue1=false;
   bool checkValue2=false;

   String radioValue="";
   var art=Article();

  DataBaseHelper db=DataBaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout d'un nouveau produit"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomTextField(
                    typeClavier: TextInputType.number,
                    label: "code article",
                    hint: "donne le code de article",
                    filterInput: [FilteringTextInputFormatter.digitsOnly],
                    validation: (value) {
                      if (value == null || value.length == 0)
                        return "le code article est obligatoire";
                      if (int.parse(value) >= 1000)
                        return null;
                      return "le code article est incorrect >1000";
                    },
                    onsaved: (value){
                        art.setCode=value!;
                    },),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.text,
                  label: "libelle article",
                  hint: "donner le libelle article",
                  validation: (value){
                        if(value == null || value.length == 0)
                          return "le libelle article est obligatoire";
                        if(value.length<6)
                          return "le libelle faut avoir 6 characters au minimum";
      
                  },
                  onsaved: (value){
                    art.lib=value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  typeClavier: TextInputType.number,
                  label: "quantite",
                  hint: "quantite",
                  filterInput: [FilteringTextInputFormatter.digitsOnly],
                  validation: (value){
                    if(value == null || value.length == 0)
                      return "le quantite est obligatoire";
                    if(int.parse(value) >= 10000 )
                      return "quantite depasse le valeur max";
                  },
                  onsaved: (value){
                      art.qte=double.parse(value!);
                  },
                ),
                const SizedBox(height: 20,),
                 FormField(
                  builder: (state){
                    return Row(
                    children: [
                      CustomCheckBox(title: "vente sur place", 
                      value: checkValue1,
                      onchange: (value){
                        setState(() {
                        checkValue1=value!;
                          
                        });
                        print("ischecked");}
                        ),
                       
                           CustomCheckBox(
                          value: checkValue2,
                          title: "vente en ligne ", 
                      onchange: (value){
                        
                        setState(() {
                          checkValue2=value!;
                        });
                        print("ischecked");}
                        ) 
                        ,
                    ],
                                 ); 

                  },
                  validator: (_){
                      if(checkValue1==false && checkValue2==false){
                        return "you have to check one of sells types";
                      }
                  },
                  onSaved: (value){
                    List<String>lst=[];
                    if(checkValue1==true) lst.add("vente sur place");
                    if(checkValue2==true) lst.add("vent en ligne");
                    art.setTypevente=jsonEncode(lst);
                  },
                   
                 ),
                //checkValue1==false && checkValue2==false?Text("not valid check box"):
                const SizedBox(height: 20,),
                 Row(
                  children: [
                   FormField(
                    builder: (state){
                      return 
                      CustomRadioButton(
                      titre:"Disponible",
                      value:"D",
                      groupvalue:radioValue,
                      onchanged: (String? value){
                        
                        setState(() {
                        radioValue=value!;
                          
                        });
                      },  
                     );

                    },
                    onSaved: (value){
                        art.setDispo=radioValue;
                    },
                   ),FormField(
                    builder: (state){
                      return 
                        CustomRadioButton(
                      titre:" sur commende",
                      value:"C",
                      groupvalue:radioValue,
                      onchanged: (String? value){
                        setState(() {
                        radioValue=value!;
                          
                        });
                      },
                     );  
                    },
                    onSaved: (_){
                      art.setDispo=radioValue;
                    },
                    
                   )
                  ],
                ),
                const SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      titre: "sauvgarder ",
                      couleur: Colors.blue,

                      onpressed: ()async {
                        if (formkey.currentState!.validate()&& (checkValue1!=false || checkValue2!=false))
                        {print("form ok");
                        formkey.currentState!.save();
                        print(art);
                        // int response=await sqldb.insertData(
                        //   '''
                        //         INSERT INTO produits (code,lib,qte,typevente,disponible) VALUES ("${art.code}","${art.lib}","${art.qte}","${art.typevente!.join(",")}","${art.dispo}")
                        //   '''
                        // );
                        // if (response>0){
                        //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AllProduit()),(route)=>false);
                        // }

                        db.add(art);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AllProduit2()),(route)=>false);
                        }
                        else {
                        print("non valid");
                        //afficher use altert 
                        afficheUneAlert(context);
                        //afficeDialog(context);
                        }
                      },
                      
                    ),
                    
                    CustomElevatedButton(
                      titre: "Annuler",
                      couleur: Colors.red,
                      onpressed: () {
                        print("annuler");
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Future afficheUneAlert(BuildContext context) {
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
      icon:Icon(Icons.error),
      title:Text("Error Detecter"),
      content: Text("Veuillez corriger les erreurs detectee !",style:TextStyle(color:Colors.red,fontSize:20.0)),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("OK"))
      ],
    );
    });

  }
}

// void afficeDialog(BuildContext context){
//   AwesomeDialog(
//             context: context,
//             dialogType: DialogType.info,
//             animType: AnimType.rightSlide,
//             title: 'Dialog Title',
//             desc: 'Dialog description here.............',
//             btnCancelOnPress: () {},
//             btnOkOnPress: () {},
//             )..show();
// }
