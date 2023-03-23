

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IData{

  Stream<QuerySnapshot<Map<String, dynamic>>> get(String koleksiyonAdi);
 Future<void> set(String koleksiyonAdi, String text);
  Future<void> updateDoc(String koleksiyonAdi, String text, String docu);
  delete(String koleksiyonAdi, String id);
}