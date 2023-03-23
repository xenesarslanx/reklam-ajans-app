import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/dbInMethod.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class KarZarar extends StatefulWidget {
  const KarZarar({super.key});

  @override
  State<KarZarar> createState() => _KarZararState();
}

class _KarZararState extends State<KarZarar> {
  TextEditingController notKontrol = TextEditingController();
  String bosText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kar-Zarar Gelir-Gider")),
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 2,
                controller: notKontrol,
                decoration: const InputDecoration(
                  icon: Icon(Icons.note_add),
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                  hintText: 'Not Gir',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w300),
                onChanged: (value) {
                  setState(() {
                    bosText = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                 dbInMethod("karzarar", bosText);
                });
              },
              child: const Text("Kaydet"),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('karzarar'), //FirebaseDb().get("stoksorgu"),
                  builder: (context, snapshot) {
                    QuerySnapshot<Map<String, dynamic>>? documentsData = snapshot.data;

                    return
              snapshot.data == null ? const Center(child: CircularProgressIndicator()) :
                    
                     ListView.builder(
                      itemCount: documentsData!.docs.isEmpty ? 0 : documentsData.docs.length,
                      itemBuilder: (context, index) {
                        final data = documentsData.docs[index];
//print(documentsData.docs[0].id);

                        TextEditingController controller =
                            TextEditingController(text: data['yazi']);

                        return ListTile(
                            subtitle: Text(data['tarih']),
                            trailing:  ElevatedButton(
              onPressed: () async{
               
                  await StokSorguViewModel(FirebaseDb()).updateDoc(
                                    'karzarar',
                                    controller.text,
                                    documentsData.docs[index].id); //FirebaseDb().updateDoc('stoksorgu', controller.text,documentsData.docs[index].id );
                              print("object");
              
              },
              child: const Text("Güncelle"),
            ),
            
                            title:  TextFormField(
                              minLines: 1 ,//controller.text.length~/40,
                             maxLines: null,
                             expands: false,
                              decoration: const InputDecoration(
                                  // labelText: data['yazi']
                                  ),
                              controller: controller,
                              onChanged: (value) async {
                                controller.text == "" || controller.text.isEmpty
                                    ? await StokSorguViewModel(FirebaseDb())
                                        .delete("karzarar", data.id)
                                    : null; 

                              },
                              onEditingComplete: () async {
                            await StokSorguViewModel(FirebaseDb()).updateDoc(
                                    'karzarar',
                                    controller.text,
                                    documentsData.docs[index].id); //FirebaseDb().updateDoc('stoksorgu', controller.text,documentsData.docs[index].id );
                              print("object");
                              },
                            ),
                          );
                            
                      },
                    );
                  }),
            ),
          
          ],
        ),
      ),
    );
    
  }
}