
import 'package:flutter/material.dart';
import 'package:gestionproduit2/db/database_helper.dart';
import 'package:gestionproduit2/entite/article.dart';
import 'package:gestionproduit2/main.dart';
import 'package:gestionproduit2/widgets/MonMenu.dart';


import '../sqldb.dart';
import 'edit_Produit.dart';


class AllProduit2 extends StatefulWidget {
  const AllProduit2({super.key});

  @override
  State<AllProduit2> createState() => _AllProduit2State();
}

class _AllProduit2State extends State<AllProduit2> {

  //List produits=[];
  List articles=[];
  bool isloading=true;

  Sqldb sqldb=Sqldb();
  Article updateArticle=Article(code:"10",lib:"youssefupdate",qte:1,dispo: "Disponible",typevente: "vent en ligne");

DataBaseHelper db=DataBaseHelper.instance;



// Future<List> readData()async {
//   List response=await sqldb.readData("SELECT * FROM 'produits'");
//   print("$response");
//   produits.addAll(response);
//   isloading=false;
//     if (this.mounted){
//       setState(() {   
//       });
//     }
//   return response;
// } 
Future<List> readData2()async{
  List response=await db.readData();
  articles.addAll(response);
  if(this.mounted){
    isloading=false;
    setState(() {
      
    });
  }
  return response;
}

@override
  void initState() {
    readData2();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Home page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
              Navigator.of(context).pushNamed("addproduit");
        },
        child: const Icon(Icons.add),
      ),
      drawer: MonMenu(),
      body:Container(
        child:isloading? const Center(child: CircularProgressIndicator()): 
        ListView(
          children: [
            ListView.builder(
                    itemCount: articles.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,i){
                    return InkWell(
                      onTap: () {
                        print (articles[i]["id"]);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text("${articles[i]['code']}"),
                          title: Text("${articles[i]['libelle']}"),
                          subtitle: articles[i]['disponible']=="D"?Text("disponible"):Text("sur comande"),
                          
                          trailing:
                              Container(
                                width: 100,
                                color: Color.fromARGB(255, 132, 201, 228),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: ()async{
                                        //update 
                                      //   int response=await db.updateData('''
                                      //   UPDATE Article
                                      //   SET 
                                      //     code = '${updateArticle.code}',
                                      //     libelle = '${updateArticle.lib}',
                                      //     qte = '${updateArticle.qte}',
                                      //     typedevente= '${updateArticle.typevente}',
                                      //     dispo='${updateArticle.dispo}'
                                      //  WHERE id=${articles[i]['id']}''');
                                      //   if(response>0){
                                       
                                      //     //articles.rep((element) => element["id"]==articles[i]['id']);
                                      //     setState(() {
                                      //       articles=[];
                                            
                                      //       readData2();
                                      //     });
                                      //   }

                                      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProduct(article:Article)));

                                      },
                                      color: Colors.blue,
                                                            
                                                          ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: ()async{
                                        int response=await db.deletetData("DELETE FROM Article WHERE id=${articles[i]['id']}");
                                        if(response>0){
                                          articles.removeWhere((element) => element["id"]==articles[i]['id']);
                                          setState(() {
                                            
                                          });
                                        }
                                      },
                                      color: Colors.red,
                                                            
                                                          ),
                                  ],
                                ),
                              ) ,
                        ),
                      ),
                    );
                  },
                  ),  
          ],
          
        ),
      )
    );
  }
}