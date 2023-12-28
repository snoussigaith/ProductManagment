import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb{

  static Database? _db;

  Future<Database?> get db async{
    if(_db==null){
      _db=await initialDB();
    }
    return _db;
  }


// database creation function 
   initialDB() async {
      String databasepath = await getDatabasesPath() ; 
      String path=join(databasepath,"youssefProduit.db"); // path/youssef.db
      Database mydb=await openDatabase(path, onCreate: _oncreate,version: 1);
      return mydb;
  }

_oncreate(Database db,int version) async{
  await db.execute('''
  CREATE TABLE produits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code INTEGER NOT NULL,
    lib TEXT NOT NULL,
    qte INTEGER NOT NULL,
    typevente TEXT NOT NULL,
    disponible TEXT NOT NULL
);
 ''') ;
print("produit table is created ******************************** ");
}

/// selecat from database 
readData(String sql)async{
  Database? mydb=await db;
  List<Map> response =await mydb!.rawQuery(sql);
    return response;
}

///insert to the database 

insertData(String sql)async{
  Database? mydb=await db;
  int response =await mydb!.rawInsert(sql);
    return response;
}

// udpate database 
updateData(String sql)async{
  Database? mydb=await db;
  int response =await mydb!.rawUpdate(sql);
    return response;
}

// delete from database 
deletetData(String sql)async{
  Database? mydb=await db;
  int response =await mydb!.rawDelete(sql);
    return response;
}
}