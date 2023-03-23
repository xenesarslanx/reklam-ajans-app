import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onur_reklam/Database/IData.dart';

class FirebaseDb implements IData{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 static var date = (
    "${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}\n"//gün:ay:yıl
    "${DateTime.now().hour}:${DateTime.now().minute}");//saat:dakika
  
  @override
Stream<QuerySnapshot<Map<String, dynamic>>> get(String koleksiyonAdi)  {

 return FirebaseFirestore
                  .instance
                  .collection(koleksiyonAdi)
                  .snapshots();
}

  @override
 Future<void> set(String koleksiyonAdi, String text) async {
   final CollectionReference collectionRef = firestore.collection(koleksiyonAdi);
  final QuerySnapshot querySnapshot = await collectionRef.get();

 if (querySnapshot.docs.isNotEmpty && querySnapshot.docs != ""){
  await firestore
    .collection(koleksiyonAdi)
    .doc(text)
    .set({
       'yazi': text,
       'tarih':date,
    });
print("setleme başarılı");
 }
  }
  
  @override
  Future<void> updateDoc(String koleksiyonAdi, String text, String docu) async{
   
 try{
  await firestore
    .collection(koleksiyonAdi)
    .doc(docu)
    .update({
       'yazi': text,
       'tarih': date,
    });
print('Belge başarıyla güncellendi.');
 } catch(e){"hataaa: $e.toString()";}
  }
  
  @override
  Future<void> delete(String koleksiyonAdi, id) async {
  var ref =  await firestore
    .collection(koleksiyonAdi)
    .doc(id)
    .delete();
    print('silme başarılı');
    return ref;
  }
    
  }

