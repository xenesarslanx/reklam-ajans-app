import 'package:flutter/material.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/myTextFormField.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class StokSorguP extends StatelessWidget {
  const StokSorguP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stok Sorgu Ekranı")),

      body: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('stoksorgu'), //FirebaseDb().get("stoksorgu"),
                  builder: (context, snapshot) {
                  
                    var documentsData = snapshot.data;
              return 
              snapshot.data == null ? const Center(child: CircularProgressIndicator()) :
              snapshot.data!.docs.isEmpty ? const Text("Henüz Veri Yok", textAlign: TextAlign.center, textScaleFactor: 4,) : 

                     ListView.builder(
                      itemCount: documentsData!.docs.isEmpty ? 0 : documentsData.docs.length,
                      itemBuilder: (context, index) {
                        final data = documentsData.docs[index];
//print(documentsData.docs[0].id);

                        TextEditingController controller =
                            TextEditingController(text: data['yazi']);

                        return ListTile(
                            title: myTextFormFieldWidget(false, "stoksorgu",controller, documentsData, index, data)
                            );
                      },
                    );
                  }),
    );
  }
}