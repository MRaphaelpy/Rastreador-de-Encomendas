import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
const String encomendaTable = 'encomendaTable';
const String idColumn = 'idColumn';
const String titleColumn = 'titleColumn';
const String trackcodeColumn = 'trackcodeColumn';

class EncomendaHelper {
  static final EncomendaHelper _instance = EncomendaHelper.internal();

  factory EncomendaHelper()=> _instance;

  EncomendaHelper.internal();

   Database? _db;

 Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    else{
      _db = await initDb();
      return _db;
    }
  }
  Future <Database>initDb() async{
    final databassesPath = await getDatabasesPath();
    final path = join(databassesPath, 'Encomendas2.db');

  return await openDatabase(path, version: 1, onCreate: (Database db, dynamic newVersion) async{
      await db.execute(
        "CREATE TABLE $encomendaTable( $idColumn INTEGER PRIMARY KEY, $titleColumn TEXT, $trackcodeColumn TEXT)"
            
      );
    });
  }

 Future saveEncomenda(encomenda) async{
    Database? dbEncomenda = await db;
    encomenda.id = await dbEncomenda!.insert(encomendaTable, encomenda.toMap());
    return encomenda;
  }

  Future getEncomenda(id) async{
     Database? dbEncomenda = await db;
     List maps = await dbEncomenda!.query(encomendaTable, columns: [idColumn, titleColumn, trackcodeColumn],
     where: "$idColumn = ?",
     whereArgs: [id]
     );
     if(maps.isNotEmpty){
       return TransactionsM.fromMap(maps.first);
     }
     else{
       return null;
     }
   }

  Future deleteEncomenda( id) async{
     Database? dbEncomenda = await db;
  return await dbEncomenda!.delete(encomendaTable, where: "$idColumn = ?", whereArgs: [id]);
   }

  Future updateEncomenda(encomenda)async{
     Database? dbEncomenda = await db;
   return await  dbEncomenda!.update(encomendaTable, encomenda.toMap(), where:'$idColumn = ?', whereArgs: [encomenda.id]);
   }

  Future<List> getAllEncomendas() async{
     Database? dbEncomenda = await db;
     List listmap = await dbEncomenda!.rawQuery("SELECT * FROM $encomendaTable");
     List<TransactionsM> listEncomendas = [];
     for(Map m in listmap){
       listEncomendas.add(TransactionsM.fromMap(m));
     }
     return listEncomendas;
   }

   Future getNumber() async{
     Database? dbEncomenda = await db;
     return Sqflite.firstIntValue(await dbEncomenda!.rawQuery("SELECT COUNT(*) FROM $encomendaTable"));
   }
  Future close() async{
     Database? dbEncomenda = await db;
     dbEncomenda!.close();
   }
  
}

class TransactionsM{
   dynamic id;
   dynamic title;
   dynamic trackCode;

TransactionsM.fromMap(Map map){
  id = map[idColumn];
  title = map[titleColumn];
  trackCode = map[trackcodeColumn];
}

Map toMap(){
  Map<String, dynamic> map = {
    titleColumn : title,
    trackcodeColumn: trackCode,
  };
  if(id != null){
    map[idColumn]=id;
  }
  return map;
  
}

@override
String toString(){
  return 'Encomenda(id: $id, nome: $title, codigo: $trackCode)';
}

  TransactionsM({this.id, this.title, this.trackCode});

}
