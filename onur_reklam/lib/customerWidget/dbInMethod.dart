  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onur_reklam/Database/firebase.dart';

void dbInMethod(String koleksiyonAdi, String bosText) {
      FirebaseFirestore.instance
        .collection(koleksiyonAdi)
        .doc(bosText)
        .set(
      {
        if (bosText.isNotEmpty) 
        'tarih': FirebaseDb.date,
        'yazi': bosText,
      },
    );
  }