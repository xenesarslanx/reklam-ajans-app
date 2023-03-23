import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/dbInMethod.dart';
import 'package:onur_reklam/customerWidget/myTextFormField.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class StokSorgu extends StatefulWidget {
  const StokSorgu({Key? key}) : super(key: key);

  @override
  State<StokSorgu> createState() => _StokSorguState();
}

class _StokSorguState extends State<StokSorgu> {
  TextEditingController notKontrol = TextEditingController();
  String bosText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stok Sorgulama")),
      body:SizedBox(
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
                 dbInMethod("stoksorgu", bosText);
                });
              },
              child: const Text("Kaydet"),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('stoksorgu'), //FirebaseDb().get("stoksorgu"),
                  builder: (context, snapshot) {
                    final documentsData = snapshot.data;

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
                            title: myTextFormFieldWidget(true, "stoksorgu",controller, documentsData, index, data));
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
