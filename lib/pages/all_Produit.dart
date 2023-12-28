
import 'package:flutter/material.dart';

import '../sqldb.dart';


class AllProduit extends StatefulWidget {
  const AllProduit({super.key});

  @override
  State<AllProduit> createState() => _AllProduitState();
}

class _AllProduitState extends State<AllProduit> {

  List produits=[];
  bool isloading=true;

  Sqldb sqldb=Sqldb();

Future<List> readData()async {
  List response=await sqldb.readData("SELECT * FROM 'produits'");
  print("$response");
  produits.addAll(response);
  isloading=false;
    if (this.mounted){
      setState(() {   
      });
    }
  return response;
} 

@override
  void initState() {
    readData();
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
      body:Container(
        child:isloading? const Center(child: CircularProgressIndicator()): ListView(
          children: [
            ListView.builder(
                    itemCount: produits.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,i){
                    return Card(
                      child: ListTile(
                        leading: Text("${produits[i]['code']}"),
                        title: Text("${produits[i]['lib']}"),
                        subtitle: produits[i]['disponible']=="D"?Text("disponible"):Text("sur comande"),
                        
                        trailing:IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: ()async{
                            int response=await sqldb.deletetData("DELETE FROM produits WHERE id=${produits[i]['id']}");
                            if(response>0){
                              produits.removeWhere((element) => element["id"]==produits[i]['id']);
                              setState(() {
                                
                              });
                            }
                          },
                          color: Colors.red,
                        ) ,
                      ),
                    );
                  })  
          ],
        ),
      )
    );
  }
}