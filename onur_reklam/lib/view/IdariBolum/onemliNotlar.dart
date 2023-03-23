import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/dbInMethod.dart';
import 'package:onur_reklam/customerWidget/myTextFormField.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class OnemliNotlar extends StatefulWidget {
  const OnemliNotlar({super.key});

  @override
  State<OnemliNotlar> createState() => _OnemliNotlarState();
}

class _OnemliNotlarState extends State<OnemliNotlar> {
   TextEditingController notKontrol = TextEditingController();
  String bosText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Önemli Notlar")),
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
                 dbInMethod("onemlinotlar", bosText);
                });
              },
              child: const Text("Kaydet"),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('onemlinotlar'), //FirebaseDb().get("stoksorgu"),
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
                            title: myTextFormFieldWidget(true, "onemlinotlar",controller, documentsData, index, data));
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