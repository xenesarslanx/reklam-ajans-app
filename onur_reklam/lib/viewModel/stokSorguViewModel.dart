import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onur_reklam/Database/IData.dart';

class StokSorguViewModel{
 

  StokSorguViewModel(IData db){
    database = db;
  }
IData? database;

  Future<void> set(String koleksiyonAdi, String text) async{
  await database!.set(koleksiyonAdi, text);
  }

Stream<QuerySnapshot<Map<String, dynamic>>> get(String koleksiyonAdi){

return database!.get(koleksiyonAdi);
}

Future<void> updateDoc(String koleksiyonAdi, String text, String docu) async{

database!.updateDoc(koleksiyonAdi, text, docu);
}

Future<void> delete(String koleksiyonAdi, id) async {
  await database!.delete(koleksiyonAdi, id);
}
}