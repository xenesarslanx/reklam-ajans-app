import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/dbInMethod.dart';
import 'package:onur_reklam/customerWidget/myTextFormField.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class PersonelOrganize extends StatefulWidget {
  const PersonelOrganize({super.key});

  @override
  State<PersonelOrganize> createState() => _PersonelOrganizeState();
}
//personelorganize
class _PersonelOrganizeState extends State<PersonelOrganize> {
  TextEditingController notKontrol = TextEditingController();
  String bosText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personel Organize")),
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
                  dbInMethod('personelorganize', bosText);
                });
              },
              child: const Text("Kaydet"),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('personelorganize'), //FirebaseDb().get("stoksorgu"),
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
                            title: myTextFormFieldWidget(true, "personelorganize",controller, documentsData, index, data));
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