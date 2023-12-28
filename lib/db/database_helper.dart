


import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../entite/article.dart';

class DataBaseHelper{
  
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance =DataBaseHelper._privateConstructor();

  DataBaseHelper();

  static Database? _database;
  Future<Database> get database async =>_database ??=await _initDatabase();

  Future<Database> _initDatabase () async{
    Directory doc=await getApplicationDocumentsDirectory();
    String path=join(doc.path,'Monstock.db');

    return await openDatabase(
      path,
      version:1,
      onCreate: _onCreate,
    );


  }

  Future _onCreate(Database db,int version)async{
    print ("creation database");
    await db.execute(
      '''
        CREATE TABLE Article(
          id INTEGER PRIMARY KEY,
          code TEXT NOT NULL,
          libelle TEXT NOT NULL,
          qte Double,
          typedevente TEXT NOT NULL,
          dispo TEXT NOT NULL
        );
      '''
    );
  }

  Future<int> add (Article article ) async{
      Database db=await instance.database;
      print ("article ajouter");
      return await db.insert('Article', article.toMap());

  }

 Future<List> readData()async{
  Database? db=await instance.database;
  List<Map> response =await db!.rawQuery('''
      SELECT * FROM Article ;
'''
);
    return response;
}

Future<int> updateData(String sql)async{
  Database? db=await instance.database;
  int response =await db!.rawUpdate(sql);
    return response;
}

Future<int> deletetData(String sql)async{
  Database? mydb=await instance.database;
  int response =await mydb!.rawDelete(sql);
    return response;
}
  

}